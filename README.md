# Simon Bourrat Website

A Jekyll-based website with Gulp for asset optimization.

## Getting Started

### Prerequisites

Ensure you have the following installed:
- [Ruby](https://www.ruby-lang.org/en/downloads/) (version compatible with Gemfile, e.g., 2.4+)
- [Node.js](https://nodejs.org/) (version compatible with Gulp 3.x, e.g., 10 or 12 is recommended for older Gulp versions)
- [Bundler](https://bundler.io/) (`gem install bundler`)

### Installation

1. Clone the repository.
2. Install Ruby dependencies:
   ```bash
   bundle install
   ```
3. Install Node.js dependencies:
   ```bash
   npm install
   ```

### Available Scripts

In the project directory, you can run:

#### `npm run serve`
Runs the Jekyll server locally at `http://localhost:4000`.

#### `npm run build`
Builds the website for production. It generates the site using Jekyll and then runs Gulp to optimize assets (minification, revisioning, etc.) in the `_site/` directory.

#### `npm run preview`
Builds the website and starts a local server to preview the production-ready build at `http://localhost:4000`.