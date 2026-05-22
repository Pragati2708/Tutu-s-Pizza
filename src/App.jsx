import { useState } from "react";

export default function App() {
  const [activeTab, setActiveTab] = useState("home");
  const [cart, setCart] = useState([]);

  const pizzas = [
    {
      id: 1,
      name: "Margherita Pizza",
      price: 199,
      image:
        "https://images.unsplash.com/photo-1604382354936-07c5d9983bd3",
    },
    {
      id: 2,
      name: "Farmhouse Pizza",
      price: 299,
      image:
        "https://images.unsplash.com/photo-1513104890138-7c749659a591",
    },
    {
      id: 3,
      name: "Pepperoni Pizza",
      price: 399,
      image:
        "https://images.unsplash.com/photo-1594007654729-407eedc4be65",
    },
    {
      id: 4,
      name: "Veggie Loaded Pizza",
      price: 349,
      image:
        "https://images.unsplash.com/photo-1541745537411-b8046dc6d66c",
    },
  ];

  const addToCart = (pizza) => {
    setCart([...cart, pizza]);
  };

  return (
    <div style={styles.app}>
      {/* Navbar */}
      <nav style={styles.navbar}>
        <h1 style={styles.logo}>🍕 Tutu's Pizza</h1>

        <div style={styles.navLinks}>
          <button
            style={styles.navButton}
            onClick={() => setActiveTab("home")}
          >
            Home
          </button>

          <button
            style={styles.navButton}
            onClick={() => setActiveTab("menu")}
          >
            Menu
          </button>

          <button
            style={styles.navButton}
            onClick={() => setActiveTab("cart")}
          >
            Cart ({cart.length})
          </button>

          <button
            style={styles.navButton}
            onClick={() => setActiveTab("contact")}
          >
            Contact Us
          </button>
        </div>
      </nav>

      {/* HOME */}
      {activeTab === "home" && (
        <div>
          <section style={styles.hero}>
            <h2 style={styles.heroTitle}>
              Hot & Fresh Pizza Delivered Fast 🚀
            </h2>

            <p style={styles.heroText}>
              Experience delicious pizzas with automated DevSecOps deployment.
            </p>

            <button
              style={styles.orderButton}
              onClick={() => setActiveTab("menu")}
            >
              Order Now
            </button>
          </section>

          <section style={styles.featuresSection}>
            <div style={styles.featureCard}>
              <h3>🔥 Fresh Ingredients</h3>
              <p>Prepared daily with premium toppings.</p>
            </div>

            <div style={styles.featureCard}>
              <h3>⚡ Fast Delivery</h3>
              <p>Delivered hot and fresh in minutes.</p>
            </div>

            <div style={styles.featureCard}>
              <h3>🍕 Best Taste</h3>
              <p>Authentic Italian flavor with modern recipes.</p>
            </div>
          </section>
        </div>
      )}

      {/* MENU */}
      {activeTab === "menu" && (
        <div style={styles.menuContainer}>
          <h2 style={styles.menuTitle}>Our Pizza Menu 🍕</h2>

          <div style={styles.pizzaGrid}>
            {pizzas.map((pizza) => (
              <div key={pizza.id} style={styles.card}>
                <img
                  src={pizza.image}
                  alt={pizza.name}
                  style={styles.image}
                />

                <div style={styles.cardBody}>
                  <h3>{pizza.name}</h3>

                  <p style={styles.price}>₹{pizza.price}</p>

                  <button
                    style={styles.addButton}
                    onClick={() => addToCart(pizza)}
                  >
                    Add to Cart
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* CART */}
      {activeTab === "cart" && (
        <div style={styles.cartContainer}>
          <h2>🛒 Your Cart</h2>

          {cart.length === 0 ? (
            <p>Your cart is empty.</p>
          ) : (
            <div>
              {cart.map((item, index) => (
                <div key={index} style={styles.cartItem}>
                  <span>{item.name}</span>
                  <span>₹{item.price}</span>
                </div>
              ))}

              <h3 style={{ marginTop: "20px" }}>
                Total: ₹
                {cart.reduce((total, item) => total + item.price, 0)}
              </h3>
            </div>
          )}
        </div>
      )}

      {/* CONTACT */}
      {activeTab === "contact" && (
        <div style={styles.contactContainer}>
          <h2>📞 Contact Us</h2>

          <p>Email: support@tutuspizza.com</p>

          <p>Phone: +91 9876543210</p>

          <p>Location: Mumbai, India</p>

          <div style={styles.contactBox}>
            <h3>We Deliver Happiness 🍕</h3>

            <p>
              Reach out for orders, feedback, or partnership opportunities.
            </p>
          </div>
        </div>
      )}

      {/* Footer */}
      <footer style={styles.footer}>
        Built with ❤️ using React + DevSecOps
      </footer>
    </div>
  );
}

const styles = {
  app: {
    fontFamily: "Arial, sans-serif",
    backgroundColor: "#f4f4f4",
    minHeight: "100vh",
  },

  navbar: {
    backgroundColor: "#d62828",
    color: "white",
    padding: "15px 40px",
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    flexWrap: "wrap",
    boxShadow: "0 4px 10px rgba(0,0,0,0.2)",
  },

  logo: {
    margin: 0,
    fontSize: "32px",
  },

  navLinks: {
    display: "flex",
    gap: "15px",
  },

  navButton: {
    backgroundColor: "white",
    color: "#d62828",
    border: "none",
    padding: "10px 18px",
    borderRadius: "8px",
    cursor: "pointer",
    fontWeight: "bold",
  },

  hero: {
    textAlign: "center",
    padding: "100px 20px",
    background: "linear-gradient(to right, #d62828, #f77f00)",
    color: "white",
  },

  heroTitle: {
    fontSize: "55px",
    marginBottom: "20px",
  },

  heroText: {
    fontSize: "22px",
    marginBottom: "30px",
  },

  orderButton: {
    backgroundColor: "white",
    color: "#d62828",
    border: "none",
    padding: "15px 30px",
    borderRadius: "10px",
    fontSize: "18px",
    fontWeight: "bold",
    cursor: "pointer",
  },

  featuresSection: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(250px,1fr))",
    gap: "20px",
    padding: "50px",
  },

  featureCard: {
    backgroundColor: "white",
    padding: "30px",
    borderRadius: "15px",
    textAlign: "center",
    boxShadow: "0 2px 10px rgba(0,0,0,0.15)",
  },

  menuContainer: {
    padding: "50px",
  },

  menuTitle: {
    textAlign: "center",
    marginBottom: "40px",
    fontSize: "40px",
  },

  pizzaGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(280px,1fr))",
    gap: "30px",
  },

  card: {
    backgroundColor: "white",
    borderRadius: "15px",
    overflow: "hidden",
    boxShadow: "0 4px 12px rgba(0,0,0,0.15)",
  },

  image: {
    width: "100%",
    height: "250px",
    objectFit: "cover",
  },

  cardBody: {
    padding: "20px",
  },

  price: {
    color: "#d62828",
    fontSize: "22px",
    fontWeight: "bold",
  },

  addButton: {
    width: "100%",
    padding: "12px",
    marginTop: "10px",
    backgroundColor: "#d62828",
    color: "white",
    border: "none",
    borderRadius: "8px",
    cursor: "pointer",
    fontWeight: "bold",
  },

  cartContainer: {
    padding: "50px",
    minHeight: "60vh",
  },

  cartItem: {
    backgroundColor: "white",
    marginBottom: "15px",
    padding: "20px",
    borderRadius: "10px",
    display: "flex",
    justifyContent: "space-between",
    boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
  },

  contactContainer: {
    padding: "50px",
    textAlign: "center",
    minHeight: "60vh",
  },

  contactBox: {
    marginTop: "30px",
    backgroundColor: "white",
    padding: "30px",
    borderRadius: "15px",
    maxWidth: "600px",
    marginInline: "auto",
    boxShadow: "0 2px 10px rgba(0,0,0,0.1)",
  },

  footer: {
    backgroundColor: "#111",
    color: "white",
    textAlign: "center",
    padding: "20px",
    marginTop: "40px",
  },
};