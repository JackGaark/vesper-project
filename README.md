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

## Upgrade plan

The dependency lockfile includes old Rails and third-party packages; this local baseline is not a production security certification. Bootstrap 3 remains in use and npm reports a moderate advisory; moving to Bootstrap 5 requires updating the existing layouts and components. First audit the locked Ruby and JavaScript dependencies and replace unsupported or vulnerable packages. Upgrade Rails in supported increments, update framework defaults and address deprecations at each step, then upgrade Ruby to a supported release compatible with the resulting stack. Replace or upgrade legacy CarrierWave/Cloudinary and Sass tooling, and verify Facebook authentication with current provider requirements. Run the request suite and exercise registration, venue selection, voting and contributions after every upgrade. Add CI and production configuration checks before deployment.
