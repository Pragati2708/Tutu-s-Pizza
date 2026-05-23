resource "aws_ecr_repository" "tutus_pizza_repo" {
  name = "tutus-pizza-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "Tutus Pizza ECR"
  }
}
resource "aws_ecs_cluster" "tutus_pizza_cluster" {
  name = "tutus-pizza-cluster"

  tags = {
    Name = "Tutus Pizza ECS Cluster"
  }
}
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "tutus-pizza-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_vpc" "tutus_pizza_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tutus-pizza-vpc"
  }
}
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.tutus_pizza_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tutus-pizza-public-subnet-1"
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.tutus_pizza_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tutus-pizza-public-subnet-2"
  }
}
resource "aws_internet_gateway" "tutus_pizza_igw" {
  vpc_id = aws_vpc.tutus_pizza_vpc.id

  tags = {
    Name = "tutus-pizza-igw"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.tutus_pizza_vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.tutus_pizza_igw.id
  }

  tags = {
    Name = "tutus-pizza-public-route-table"
  }
}
resource "aws_route_table_association" "public_subnet_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id

  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_subnet_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id

  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_security_group" "alb_sg" {
  name        = "tutus-pizza-alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.tutus_pizza_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tutus-pizza-alb-sg"
  }
}
resource "aws_security_group" "ecs_sg" {
  name        = "tutus-pizza-ecs-sg"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.tutus_pizza_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"

    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tutus-pizza-ecs-sg"
  }
}
resource "aws_lb" "tutus_pizza_alb" {
  name               = "tutus-pizza-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]

  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "Tutus Pizza ALB"
  }
}
resource "aws_lb_target_group" "tutus_pizza_tg" {
  name        = "tutus-pizza-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = aws_vpc.tutus_pizza_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"

    healthy_threshold   = 2
    unhealthy_threshold = 2

    timeout             = 5
    interval            = 30

    matcher             = "200"
  }

  tags = {
    Name = "Tutus Pizza Target Group"
  }
}
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.tutus_pizza_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"

    target_group_arn = aws_lb_target_group.tutus_pizza_tg.arn
  }
}
resource "aws_ecs_task_definition" "tutus_pizza_task" {
  family                   = "tutus-pizza-task"

  network_mode             = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "tutus-pizza-container"

      image = "779846808506.dkr.ecr.ap-south-1.amazonaws.com/tutus-pizza-repo:latest"

      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}
resource "aws_ecs_service" "tutus_pizza_service" {
  name            = "tutus-pizza-service"

  cluster         = aws_ecs_cluster.tutus_pizza_cluster.id

  task_definition = aws_ecs_task_definition.tutus_pizza_task.arn

  desired_count   = 1

  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id
    ]

    security_groups = [
      aws_security_group.ecs_sg.id
    ]

    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tutus_pizza_tg.arn

    container_name   = "tutus-pizza-container"

    container_port   = 80
  }

  depends_on = [
    aws_lb_listener.http_listener
  ]
}