# ERP Igreja/ONG - Estrutura do Projecto

Este projecto foi reestruturado para ser um **ERP Vertical Leve**, focado na realidade de Angola para igrejas, associações e ONGs.

## 🚀 Visão Geral
O sistema foca em cinco pilares fundamentais:
1. **Gestão de Membros**: Controlo de activos, cargos e ministérios.
2. **Transparência Financeira**: Registo rigoroso de dízimos, ofertas e despesas.
3. **Eventos e Presenças**: Gestão de cultos e actividades com controlo de custos.
4. **Comunicação Direta**: Integração com canais usados localmente (WhatsApp/SMS).
5. **Offline-First**: Funciona sem internet constante usando PowerSync + SQLite.

## 📁 Arquitetura (Clean Architecture)
A estrutura segue princípios de separação de responsabilidades:

- `lib/core/`: Utilidades globais, temas (flex_color_scheme) e constantes.
- `lib/data/`: Implementação técnica (Supabase/PowerSync), modelos e repositórios.
- `lib/domain/`: Regras de negócio puras (Entidades e Usecases).
- `lib/presentation/`: Interface do utilizador (UI), ecrãs e gestão de estado (Riverpod).

## 🛠 Stack Tecnológica
- **Mobile/Web**: Flutter
- **Base de Dados**: PostgreSQL (Supabase)
- **Sincronização**: PowerSync (Offline-first)
- **Estado**: Riverpod (Reactive)
- **UI**: FlexColorScheme + Google Fonts

## 📊 Base de Dados
O esquema SQL está documentado em `docs/database/schema.sql`.
- Tabelas principais: `members`, `financial_records`, `events`, `attendance`.

## 🔜 Próximos Passos
1. Configurar o `SupabaseConnector` e `PowerSyncService`.
2. Implementar o ecrã de Dashboard com `Syncfusion Charts`.
3. Criar o módulo de importação de CSV para membros.
