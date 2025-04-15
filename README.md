# Rsodx

<p align="left">
  <img src="docs/banner.jpg" width="300px" alt="Rsodx banner">
</p>

`rsodx` is a minimal, modular framework for building fast and maintainable Ruby microservices.  
Inspired by the best of Rails, Sinatra, and Sequel — it gives you just enough structure to scale, without the overhead.

No magic. Just clean code and powerful tools.


```bash
$ rsodx new my_rail_company
🛤️  Initializing Transport Empire...
📦 Creating folders...
✅ Done! Start building your microservice railway!
```


---

## 🧠 Philosophy

- **Micro-first** — focus on small, single-purpose services
- **Explicit over implicit** — no hidden behavior, no global state
- **Modular by design** — include only what you need
- **Ruby-native** — use familiar patterns, no learning curve
- **Production-oriented** — simple to develop, easy to deploy

---

> ✅ `rsodx` includes routing, interactors, validation, and service structure —  
all wrapped into a fast and lightweight toolkit made for modern Ruby apps.

---

## 📦 Installation

```text
gem 'rsodx', github: 'eugene-ruby/rsodx'
```

You can install the gem directly from [RubyGems.org](https://rubygems.org/gems/rsodx) after release:

### With Bundler

```bash
bundle add rsodx
```

### Without Bundler

```bash
gem install rsodx
```

---

## 🚀 CLI Commands

`rsodx` ships with a powerful and lightweight CLI tool for generating services and scaffolding applications.

You can run CLI commands via:

```bash
bin/rsodx [command] [args]
```

---

## 🔧 Generators

Generate various application components using simple commands:

```bash
bin/rsodx generate controller v1/users/index
bin/rsodx generate presenter v1/users/index
bin/rsodx generate serializer v1/users/index
```

Or using aliases:

```bash
bin/rsodx g controller v1/users/index
```

To generate **all three** at once (controller, presenter, serializer):

```bash
bin/rsodx g action v1/users/index
```

This creates:

- `app/controllers/v1/users/index_controller.rb`
- `app/presenters/v1/users/index_presenter.rb`
- `app/serializers/v1/users/index_serializer.rb`

---

## 🛠 Scaffold New App

Create a full Rsodx project with:

```bash
bin/rsodx new my_app
```

Or using alias:

```bash
bin/rsodx n my_app
```

This will create a new directory `my_app` with:

- `Gemfile`, `.env`, `.ruby-version`
- `config.ru`, `Rakefile`, environment loader
- `app/` structure (`controllers`, `services`, etc.)
- `bin/console` and `bin/rsodx` CLI entrypoints

It will be immediately runnable:

```bash
cd my_app
bundle install
bin/rsodx server
```

---

## 🌐 Server Command

Run a local Rack-based Puma server:

```bash
bin/rsodx server
```

Available options:

- `--port=PORT` – default: `9292`
- `--env=ENV` – default: `development`

Example:

```bash
bin/rsodx server --port=3000 --env=production
```

### 🔍 How it works

This command launches Puma via `rackup`:

```ruby
pid = spawn("bundle exec rackup --port=#{port} --host=0.0.0.0")
Process.wait(pid)
```

It ensures that your `config.ru` is used correctly and delegates the full startup to Rack.

---

## ✅ Command Summary

| Command | Description |
|--------|-------------|
| `rsodx new NAME` | Scaffold a new Rsodx project |
| `rsodx server` | Run the Rack/Puma development server |
| `rsodx generate controller PATH` | Generate a controller |
| `rsodx generate presenter PATH` | Generate a presenter |
| `rsodx generate serializer PATH` | Generate a serializer |
| `rsodx generate action PATH` | Generate controller + presenter + serializer |
| Aliases: `g`, `n`, `s` | All commands support short versions |

---

## 📁 Folder Structure (Generated App)

```
my_app/
├── app/
│   ├── controllers/
│   ├── presenters/
│   ├── serializers/
│   ├── services/
├── bin/
│   ├── console
│   └── rsodx
├── config/
│   ├── environment.rb
│   └── environments/
├── db/
│   └── migrations/
├── spec/
├── config.ru
├── .env
├── Gemfile
└── Rakefile
```

---

## 🗄️ PostgreSQL Setup

Your application connects to PostgreSQL using the `DATABASE_URL` defined in `.env`:

```
DATABASE_URL=postgres://rsodx:paSs4321@localhost:5432/rsodx_development
```

### 📌 To create this database manually:

1. Open your terminal and run the PostgreSQL client:

```bash
psql -U postgres
```

2. Then, execute the following SQL commands:

```sql
-- Create the user
CREATE USER rsodx WITH PASSWORD 'paSs4321';

-- Create the database
CREATE DATABASE rsodx_development;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE rsodx_development TO rsodx;
```

> 📍 If your system uses a different PostgreSQL superuser, adjust `-U postgres` accordingly.

---

## ✅ Quick Check

You can test the connection:

```bash
psql postgres://rsodx:paSs4321@localhost:5432/rsodx_development
```

If it connects successfully, your database is ready for development!

---

## 📂 DSL Router Example

```ruby
class Router < Rsodx::Router
  namespace "/v1" do
    post "/users", V1::Users::Create
  end
end
```

---

## ⚙️ Rake Tasks

You can define your own `DB.connect` logic and use built-in tasks:

```ruby
# config/environment.rb
require "rsodx"
require "rsodx/db"
Rsodx::DB.connect
```

### Run migration
```bash
rake db:migrate
```

### Rollback migration
```bash
rake db:rollback
```

---

## 💻 Interactive Console

```bash
bin/console
```
Inside IRB:
```ruby
reload!  # reload environment
CreateUser.call(params: {...})
```

---

## 🛣️ Roadmap

Planned features and improvements for upcoming versions of `rsodx`.

### 🔄 Inter-service Communication

- ✅ **Add RabbitMQ support** for event-driven microservices
    - CLI: `rsodx g subscriber user/created`
    - DSL: `on_event "user.created", with: HandleUserCreated`

### 🐳 Docker Support

- ✅ Dockerfile and docker-compose.yml templates
- PostgreSQL, RabbitMQ, App

### 📦 Generators & Tooling

- [ ] `rsodx g worker fetch_data`
- [ ] `rsodx g subscriber event_name`
- [ ] CLI flags: `--dry-run`, `--force`, `--skip`
- [ ] Generate test stubs with each component

### 🌐 Web Server Improvements

- [ ] Auto-discovery of config.ru or App class
- [ ] `rsodx server --daemon`, `--log`

### 📚 Documentation & API

- [ ] Auto-generate OpenAPI / Swagger docs from declared routes and schemas
- [ ] DRY validation + schema → Swagger with types and examples
- [ ] `rsodx g docs` or `rsodx docs generate`

### 🛠 Developer Experience

- [ ] `rsodx console` (IRB + app preload)
- [ ] `rsodx doctor` for environment diagnostics
- [ ] Starter project templates (`--template=api`, `--template=evented`)

---

If you’d like to contribute or suggest new features — feel free to open an issue or PR. Let’s make `rsodx` fast, lean and production-ready together! ❤️

---

## 🧬 License
MIT — created by Eugene Pervushin
