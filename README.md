# Rsodx

> Add Rsodx and just code ✨

Rsodx is a lightweight, modular microservice framework for Ruby — designed to be fast, clean, and scalable. It provides a minimal architecture inspired by Rails, Sinatra, and Sequel, allowing you to focus on writing business logic without boilerplate.

---

## 🧠 Philosophy

- No monoliths — build small services
- No magic — just plain Ruby
- No opinionated ORM or router — just simple tools
- Easily extendable and production-ready

---

Вот аккуратно оформленный раздел `Installation` для твоего README:

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

> ✅ `rsodx` is designed for microservice architecture and includes routing, interactors, validation, and more — all in one lightweight package.

---


## 📦 Project Structure

```text
my_service/
├── app/
│   ├── api/
│   ├── interactors/
│   ├── models/
│   ├── presenters/
│   ├── serializers/
│   ├── app.rb
│   └── router.rb
├── config/
│   ├── environment.rb
│   ├── environments/
│   └── initializers/
├── db/
│   └── migrations/
├── bin/
│   └── console
├── .env
├── config.ru
├── Gemfile
└── Rakefile
```

---

## 🧰 CLI Commands

### Create new service

```bash
rsodx new my_service
```

---

### Generate interactor

```bash
bin/rsodx generate interactor CreateUser
```
Creates `app/interactors/create_user.rb`:

```ruby
class CreateUser < Rsodx::Interactor
  def call
    # business logic here
  end
end
```

---

### Generate migration

```bash
bin/rsodx generate migration CreateUsers
```
Creates `db/migrations/20240413_create_users.rb`:

```ruby
Sequel.migration do
  change do
    # create_table :users do
    #   primary_key :id
    #   String :email
    #   DateTime :created_at
    # end
  end
end
```

---

## 📂 DSL Router Example

```ruby
class Router < Rsodx::Router
  namespace "/v1" do
    post "/users", CreateUsers
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

## 🔜 Roadmap
- Generator for models, serializers, presenters
- HTTP + JSON helpers
- Authentication middleware
- Better documentation site

---

## 🧬 License
MIT — created by Eugene Pervushin
