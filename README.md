Orders App
==================

A simple Ruby on Rails application to manage service orders with state transitions.

Requirements
------------

- Ruby 3.x
- Rails 8.x
- SQLite3


Setup
-----

Clone the repository:

```bash
git clone <your-repo-url>\
cd service_orders_app
```

Install dependencies:

```bash
bundle install
```

Create and migrate the database:

```bash
rails db:create
rails db:migrate
```

Run the application
-------------------

Start the server:

```bash
rails server
```

Open in your browser:

```bash
http://localhost:3000
```

Run tests
---------

```bash
rails test
```

Order Workflow
--------------

- New orders start in **pending** state.
- A pending order can move to **in_progress**.
- An in_progress order can move to **completed**.
- Completed orders cannot change state.