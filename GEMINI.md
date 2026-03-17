# Gemini Project Context: Personal Website (Ruby on Rails)

This project is a personal website and blog built using **Ruby on Rails 8.1.2**. It features a public-facing site with blog posts, a project showcase, search functionality, and a secure admin dashboard for content management.

## Project Overview

*   **Core Framework:** Ruby on Rails 8.1.2
*   **Database:** PostgreSQL (using `pg` gem)
*   **Frontend:** Tailwind CSS (via `tailwindcss-rails`) with `@tailwindcss/typography` for styling Markdown content, and Hotwire (Turbo & Stimulus).
*   **Authentication:** Custom session-based authentication using `bcrypt` and `Current.user` pattern.
*   **Content Management:** Admin namespace for managing `Post` and `Project` records.
*   **Search:** Integrated search across posts and projects using `pg_search`.
*   **Markdown:** Support for Markdown content in posts and projects using `redcarpet` and `rouge` for syntax highlighting.
*   **Deployment:** Containerized deployment via **Kamal**.
*   **Modern Rails Features:** Utilizes `solid_cache`, `solid_queue`, and `solid_cable` for database-backed background jobs, caching, and real-time features.

## Key Technologies & Libraries

*   **Hotwire:** Turbo for SPA-like navigation and Stimulus for client-side interactivity.
*   **Pagy:** High-performance pagination for blog posts and search results.
*   **PgSearch:** Full-text search capabilities.
*   **Redcarpet & Rouge:** Markdown rendering with syntax highlighting.
*   **Kamal:** Deployment tool for managing Docker containers.
*   **Thruster:** HTTP asset caching and compression for Puma.

## Building and Running

### Prerequisites
*   Ruby (see `.ruby-version`)
*   PostgreSQL
*   Docker (for Kamal deployment)

### Development Setup
1.  **Install dependencies:**
    ```bash
    bundle install
    ```
2.  **Setup the database:**
    ```bash
    bin/rails db:prepare
    ```
3.  **Start the development server:**
    ```bash
    bin/dev
    ```
    *Note: `bin/dev` uses `foreman` to run both the Rails server and the Tailwind CSS watcher.*

### Testing
*   Run the test suite:
    ```bash
    bin/rails test
    ```

## Project Structure & Conventions

### Models
*   `User`: Handles admin authentication (`has_secure_password`).
*   `Post`: Blog entries with `slug` for friendly URLs and `PgSearch` integration.
*   `Project`: Showcase items with `slug` and `PgSearch` integration.
*   `Contact`: Stores messages from the contact form.

### Controllers
*   `ApplicationController`: Sets `Current.user` based on `session[:user_id]`.
*   `AdminController`: Base controller for the `admin` namespace, enforces authentication via `require_login`.
*   `Admin::DashboardController`, `Admin::PostsController`, etc.: Handle content management.
*   `PostsController`, `ProjectsController`, `SearchController`: Public-facing controllers.

### Routing
*   `root "pages#home"`: The landing page.
*   `namespace :admin`: Routes for content management.
*   `resources :posts`, `resources :projects`: Public routes with friendly URL support (overridden `to_param`).

### Helpers
*   `MarkdownHelper`: Provides a `markdown(text)` method for rendering content.

### Conventions
*   **Authentication:** Always check `Current.user` or use the `authenticated?` helper method in views.
*   **Friendly URLs:** Use `slug` instead of `id` for public-facing routes in `Post` and `Project`.
*   **Search:** Multi-searchable content across models using `pg_search_documents`.
