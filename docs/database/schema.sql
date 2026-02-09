-- ERP Vertical para Igrejas, Associações e ONGs em Angola
-- Focado em simplicidade, transparência e controle local

-- 1. EXTENSIONS
create extension if not exists "uuid-ossp";

-- 2. TABLES

-- Profiles (Administradores/Operadores do sistema)
create table profiles (
  id uuid references auth.users on delete cascade primary key,
  full_name text,
  role text check (role in ('admin', 'operator', 'viewer')),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Membros
create table members (
  id uuid primary key default uuid_generate_v4(),
  full_name text not null,
  photo_url text,
  phone text,
  email text,
  birth_date date,
  gender text check (gender in ('M', 'F')),
  address text,
  entry_date date default current_date,
  status text not null default 'active' check (status in ('active', 'absent', 'transferred', 'deceased')),
  ministry text, -- Pode ser um array ou tabela separada se complexo, mas simplificando para 'vertical'
  group_name text, -- Ex: Grupo de Jovens, Coral, etc.
  position text, -- Cargo: Pastor, Diácono, Secretário, etc.
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Gestão Financeira (Receitas e Despesas)
create table financial_records (
  id uuid primary key default uuid_generate_v4(),
  description text not null,
  amount decimal(12,2) not null,
  type text not null check (type in ('income', 'expense')),
  category text not null, -- Ex: Dízimo, Oferta, Doação, Salário, Aluguel, Evento
  record_date date not null default current_date,
  member_id uuid references members(id) on delete set null, -- Null se não for relacionado a membro (ex: despesa)
  payment_method text check (payment_method in ('cash', 'bank_transfer', 'multicaixa', 'other')),
  reference_event_id uuid, -- Relacionar com um evento específico se necessário
  recorded_by uuid references profiles(id),
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Eventos (Cultos, Reuniões, Campanhas)
create table events (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  description text,
  event_type text not null, -- Ex: Culto, Reunião, Projeto Social, Conferência
  start_at timestamptz not null,
  end_at timestamptz,
  location text,
  expected_attendance integer,
  cost decimal(12,2) default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Presenças (Attendance)
create table attendance (
  id uuid primary key default uuid_generate_v4(),
  event_id uuid references events(id) on delete cascade not null,
  member_id uuid references members(id) on delete cascade not null,
  is_present boolean default true,
  check_in_at timestamptz default now(),
  unique(event_id, member_id)
);

-- 3. POWERSYNC PUBLICATION
-- Adicionar tabelas à publicação do PowerSync
-- drop publication if exists powersync;
-- create publication powersync for table profiles, members, financial_records, events, attendance;

-- 4. RLS (Row Level Security) - Simplificado para o MVP
-- Ativar RLS em todas as tabelas
alter table profiles enable row level security;
alter table members enable row level security;
alter table financial_records enable row level security;
alter table events enable row level security;
alter table attendance enable row level security;

-- Políticas: Para o MVP, permitiremos acesso total a usuários autenticados da mesma organização
-- Nota: Em um SaaS real, adicionaríamos organization_id

create policy "Users can view all data" on members for select using (true);
create policy "Users can insert members" on members for insert with check (true);
create policy "Users can update members" on members for update using (true);

-- (Repetir padrões similares para outras tabelas conforme necessário)
