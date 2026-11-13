# Vesper

Vesper is a prototype for choosing venues and coordinating a group night out. It does **not** make reservations, process payments, or issue admission codes.

## Local setup

The current development baseline is Ruby 3.3.5, Bundler (installed automatically from `Gemfile.lock`), Node.js 24, npm, and PostgreSQL. Ensure PostgreSQL is running and the local OS user can create databases. The application uses `vesper_development` and `vesper_test` by default; `DATABASE_URL` can override the connection.

```sh
bundle install
npm ci
npm run build
bin/rails db:prepare
bin/rails server -b 127.0.0.1
```

Open http://127.0.0.1:3000. The development seed adds three sample venues and packages without deleting existing records; it can be run again with `bin/rails db:seed`. Register an account with email and password to create a squad. Re-run `npm run build` after changing JavaScript.

Run tests with `bin/rails test`. The test database is managed by Rails and must not contain data you want to keep.

Cloudinary and Facebook login are optional for local browsing. Configure `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, and `CLOUDINARY_API_SECRET` for uploads, and `FB_ID` and `FB_SECRET` for Facebook login. Do not commit these values. Existing credentials in Git history and the former Rails master key must be considered compromised: rotate them with the relevant providers and re-encrypt any still-needed Rails credentials with a new key. The old key is removed from tracking but remains in history.

## Dependency maintenance

Rails and the Ruby and JavaScript dependencies are locked in `Gemfile.lock` and `package-lock.json`. Dependabot is configured to propose weekly updates; run `bundle exec rails test` and `npm run build` when reviewing them. The app still uses Bootstrap 3 styles and older Sass tooling, which should be modernized separately. Facebook login needs a Meta app with a permitted callback URL; the full Facebook authorization flow has not yet been verified.
