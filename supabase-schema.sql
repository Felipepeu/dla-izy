-- Run this once in Supabase Dashboard > SQL Editor.
-- This no-login setup allows anyone with the site URL to edit shared content.

create table if not exists public.shared_site_state (
  id text primary key check (id = 'main'),
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

create or replace function public.set_shared_site_state_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_shared_site_state_updated_at on public.shared_site_state;
create trigger set_shared_site_state_updated_at
  before update on public.shared_site_state
  for each row execute function public.set_shared_site_state_updated_at();

alter table public.shared_site_state enable row level security;
grant select, insert, update on public.shared_site_state to anon;

drop policy if exists "Public can read shared site state" on public.shared_site_state;
create policy "Public can read shared site state"
  on public.shared_site_state for select to anon
  using (id = 'main');

drop policy if exists "Public can create shared site state" on public.shared_site_state;
create policy "Public can create shared site state"
  on public.shared_site_state for insert to anon
  with check (id = 'main');

drop policy if exists "Public can update shared site state" on public.shared_site_state;
create policy "Public can update shared site state"
  on public.shared_site_state for update to anon
  using (id = 'main')
  with check (id = 'main');

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'shared-photos',
  'shared-photos',
  true,
  10485760,
  array['image/jpeg', 'image/png', 'image/webp', 'image/gif']
)
on conflict (id) do update set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "Public can view shared photos" on storage.objects;
create policy "Public can view shared photos"
  on storage.objects for select to anon
  using (bucket_id = 'shared-photos');

drop policy if exists "Public can upload shared photos" on storage.objects;
create policy "Public can upload shared photos"
  on storage.objects for insert to anon
  with check (bucket_id = 'shared-photos');

drop policy if exists "Public can delete shared photos" on storage.objects;
create policy "Public can delete shared photos"
  on storage.objects for delete to anon
  using (bucket_id = 'shared-photos');
