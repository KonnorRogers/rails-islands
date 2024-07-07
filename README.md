# Purpose

A small POC of how you could implement "islands" in Rails using Vite + Turbo frames

## How does it work?

It works by (ab)using `additionalEntrypoints` from Vite Rails, and then using View paths as conventions to grab the associated "sidecar assets" (co-located CSS / JS files) and loads them via `<turbo-frame>`s. It also comes with an `IslandsController` for lazy loading an island from a URL.

## Whats been modified to make this work?

`config/vite.json` has the following: `"additionalEntrypoints": ["app/views/islands/**/*.(js|css)"]`

This tells it to treat any JS or CSS files in `app/views/islands` as an entrypoint that can be loaded with:

```erb
<!-- app/views/islands/_island_1.html.erb -->
<%= vite_javascript_tag "/app/views/islands/_island_1.js" %>
<%= vite_stylesheet_tag "/app/views/islands/_island_1.css" %>

<turbo-frame id="island-1">
</turbo-frame>
```

There's also an `IslandsController` which is responsible for lazy-loading islands from a url like:

`GET /islands/island_1`

## Key points:

- Supports lazy loaded islands that go to `/islands/:id` and the controller will load up the proper HTML / CSS / JS and insert via `<turbo-frame>`
- Could swap out `<turbo-frame>` for a solution like `<is-land>` for more advanced loading or some other lazy loading solution that doesn't link via id so you can load the same island multiple times on the same page.

## Caveats

- The steps for making an island are very manual right now by needing to wrap in a `<turbo-frame>`, supply an `id`, and manually add the CSS / JS files to be loaded in the view. (Check out [app/views/islands](/app/views/islands) and check out the `.html.erb` partials to see how this is done.

- Right now only 1 island is allowed per page due to how `<turbo-frame>` requires ids to work properly. This seems fine...I doubt you load the same island twice.

## Running the repo

```bash
git clone https://github.com/KonnorRogers/rails-islands.git
cd rails-islands
bundle install
npm install
overmind start -f Procfile.dev
```

Then go to `localhost:3000` and check out the magic.

