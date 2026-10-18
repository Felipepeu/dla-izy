# Wskazówki projektu

- To statyczna strona dla Izy zrobiona w HTML, CSS i JavaScript; klient Supabase jest ładowany z CDN.
- Zachowuj polski język strony (`lang="pl"`) i responsywność na telefonach.
- Publikacja docelowa: GitHub Pages z głównej gałęzi i katalogu `/`.
- Treści osobiste dopasowuj wyłącznie do informacji podanych przez Filipa.
- Wspólne dane synchronizuje Supabase bez logowania; dostęp anonimowy jest publiczny i opisany w README oraz `supabase-schema.sql`.
- W `supabase-config.js` wolno umieszczać wyłącznie Supabase Project URL i klucz `publishable`/`anon`; nigdy nie dodawaj klucza `secret` ani `service_role`.
