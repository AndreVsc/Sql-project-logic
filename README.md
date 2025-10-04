# E-commerce Database Schema 🚀

**E-commerce DB** is a comprehensive relational database schema designed to power a modern e-commerce platform. It coordinates the entire sales lifecycle—from product sourcing and inventory management to payment processing and final delivery—ensuring data integrity, scalability, and robust performance. The system is built around four core entities:

<br>

<p align="center">
  <img src="ModelER.png" alt="E-commerce Relational Model" />
</p>

<br>

* **Clients**: Manages customer data with built-in support for both individual (`B2C`) and corporate (`B2B`) accounts.

* **Products**: A flexible product catalog that includes details on categories, pricing, ratings, and multi-location inventory.

* **Orders**: The transactional core of the system, linking customers to the products they purchase and tracking payment and shipping status from start to finish.

* **Suppliers & Sellers**: Manages the product supply chain, supporting both direct inventory from suppliers and a third-party marketplace model.

## **Key Features**

* **Robust Data Modeling**: Covers the complete e-commerce workflow, including inventory, multi-channel sales, and logistics.

* **Dual Customer Support**: Natively handles both individual and corporate clients, with unique `CHECK` constraints to ensure data integrity for different document types (CPF/CNPJ).

* **End-to-End Order Tracking**: Provides a clear view of an order's journey, from payment confirmation and processing to shipping status and final delivery code.

* **Complex Relationship Management**: Efficiently handles many-to-many relationships for order items, product suppliers, and inventory locations using clean join tables.

* **Analytics-Ready**: Structured to simplify data analysis and the generation of business intelligence reports on sales trends, customer behavior, and inventory turnover.

## **Database Architecture**

The schema is designed with a clear separation of concerns, ensuring a clean and maintainable data foundation for any application built on top of it.

* **Model Layer**: Contains the core business entities (Clients, Products, Orders) and their relationships, enforced through primary and foreign keys to guarantee referential integrity.

* **Integrity Layer**: Implements business rules directly at the database level using `CHECK` constraints, `UNIQUE` indexes, and `default` values to maintain high data consistency and accuracy.

* **Query Layer**: The relational structure is optimized for complex joins and aggregations, allowing for powerful and efficient data retrieval for application backends and analytics dashboards.

<br>

**E-commerce DB** is designed with scalability at its core, ready to be deployed for a small online store or a large-scale marketplace. The project prioritizes a clean data model and a maintainable architecture to ensure long-term reliability and ease of future expansion.
