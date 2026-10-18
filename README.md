# Miejsce tylko dla Ciebie

Statyczna strona w HTML, CSS i JavaScript. Wspólna checklista, cytaty i zdjęcia mogą synchronizować się przez Supabase; budowanie strony nie wymaga Node ani własnego serwera.

## Jednorazowa konfiguracja Supabase

1. Utwórz projekt w Supabase.
2. Otwórz **SQL Editor**, wklej całą zawartość `supabase-schema.sql` i uruchom ją.
3. W ustawieniach projektu otwórz **API Keys** i skopiuj **Project URL** oraz **Publishable key**. Starszy projekt może pokazywać klucz `anon` zamiast publishable.
4. Wpisz te dwie wartości do `supabase-config.js`, odpowiednio do pól `url` i `publishableKey`. Używaj wyłącznie klucza publicznego `publishable`/`anon`. Nigdy nie wpisuj klucza `secret` ani `service_role` do strony.
5. Zapisz i wypchnij zmiany na gałąź `main`. GitHub Pages opublikuje skonfigurowaną wersję.

Przy pierwszym połączeniu aplikacja przeniesie lokalną checklistę, cytaty i zdjęcia tego urządzenia do Supabase, jeśli tabela jest jeszcze pusta. Kolejne urządzenia pobiorą wspólny stan automatycznie. Strona sprawdza nowe zmiany mniej więcej co 5 sekund. Zdjęcia są przechowywane w publicznym bucketcie Supabase Storage; pliki mogą mieć maksymalnie 10 MB.

Na planie Free Supabase może automatycznie wstrzymać projekt po okresie bezczynności. GitHub Pages nadal będzie serwować stronę, ale synchronizacja danych nie zadziała, dopóki projekt nie zostanie wznowiony. Dla ciągłej dostępności backendu może być potrzebny płatny plan.

## Ważne: tryb bez logowania

Zgodnie z prośbą nie ma logowania. Każdy, kto zna publiczny adres strony, może odczytać, dodać lub usunąć wspólne wpisy i zdjęcia. Strona jest publiczna, więc nie przechowuj w niej prywatnych ani wrażliwych informacji. Klucz `publishable`/`anon` jest przeznaczony do użycia w przeglądarce; dostęp ograniczają reguły RLS w `supabase-schema.sql`, które celowo dopuszczają wszystkich odwiedzających.

Jeśli Supabase nie jest jeszcze skonfigurowany, strona nadal działa lokalnie i pokazuje status w nagłówku. Dane lokalne nie synchronizują się, dopóki nie zostanie dodany URL projektu i klucz publiczny.

## Publikacja

Repozytorium używa GitHub Pages z gałęzi `main` i katalogu `/ (root)`. Adres strony: `https://felipepeu.github.io/dla-izy/`.
