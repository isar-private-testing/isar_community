# libmdbx-rs - Rust Bindings

## Resumo do Projeto

`libmdbx-rs` é uma biblioteca Rust que fornece bindings idiomáticos e seguros para a biblioteca [libmdbx](https://libmdbx.dqdkfa.ru), um fork melhorado do LMDB (Lightning Memory-Mapped Database). Este projeto oferece uma interface Rust de alto nível para operações de banco de dados MDBX, incluindo suporte a ORM opcional.

**Versão atual**: 0.6.2  
**Licença**: Mozilla Public License v2.0  
**Repository**: https://github.com/vorot93/libmdbx-rs

## Estrutura do Projeto

```
libmdbx-rs/
├── Cargo.toml              # Configuração principal do workspace
├── README.md              # Documentação principal
├── LICENSE                # Licença MPL-2.0
├── src/                   # Código fonte principal
├── mdbx-sys/             # Bindings FFI de baixo nível
├── benches/              # Benchmarks de performance
└── tests/                # Testes de integração
```

### Diretórios Principais

#### `/src/` - Biblioteca Principal
- **`lib.rs`**: Ponto de entrada principal, exporta todas as APIs públicas
- **`database.rs`**: Gerenciamento de bancos de dados e ambientes MDBX
- **`transaction.rs`**: Tipos e operações de transações (RO/RW)
- **`cursor.rs`**: Interface para cursores e iteradores
- **`table.rs`**: Abstração de tabelas/databases
- **`codec.rs`**: Codificação e decodificação de dados
- **`error.rs`**: Tipos de erro e tratamento
- **`flags.rs`**: Constantes e flags do MDBX
- **`orm/`**: Módulo ORM opcional (feature-gated)
  - `mod.rs`, `database.rs`, `transaction.rs`, `cursor.rs`
  - `traits.rs`, `impls.rs` - Traits e implementações do ORM

#### `/mdbx-sys/` - Bindings FFI
- **`Cargo.toml`**: Configuração do crate de sistema (versão 13.7.0)
- **`build.rs`**: Script de build que gera os bindings
- **`src/lib.rs`**: Include dos bindings gerados automaticamente
- **`libmdbx/`**: Código fonte C da biblioteca libmdbx upstream

#### `/benches/` - Benchmarks
- **`cursor.rs`**: Benchmarks de operações com cursores
- **`transaction.rs`**: Benchmarks de performance de transações
- **`utils.rs`**: Utilitários para benchmarking

#### `/tests/` - Testes
- **`environment.rs`**: Testes de ambiente e configuração
- **`transaction.rs`**: Testes de funcionalidade de transações
- **`cursor.rs`**: Testes de operações de cursor

## Arquivos de Build

### `/Cargo.toml` - Workspace Principal
- **Workspace**: Define `mdbx-sys` como membro
- **Dependências principais**:
  - `bitflags` (2): Manipulação de flags
  - `derive_more` (2): Macros de derivação
  - `parking_lot` (0.12): Primitivas de sincronização
  - `indexmap` (2): Mapas ordenados
  - `thiserror` (2): Tratamento de erros
- **Features opcionais**:
  - `orm`: Habilita funcionalidade ORM completa
  - `cbor`: Suporte a serialização CBOR
- **Dev dependencies**: `criterion`, `rand`, `serde`, `tempfile`

### `/mdbx-sys/Cargo.toml` - Crate FFI
- **Build dependencies**:
  - `cc` (1.0): Compilação de código C
  - `bindgen` (0.72): Geração automática de bindings
- **Runtime dependency**: `libc` (0.2)

### `/mdbx-sys/build.rs` - Script de Build
**Funcionalidades principais**:
1. **Geração de bindings**: Usa `bindgen` para gerar bindings Rust a partir de `mdbx.h`
2. **Compilação C**: Compila `libmdbx/mdbx.c` usando `cc`
3. **Configuração de flags**:
   - Otimizações de compilação (`-Wall`, `-Werror`, `-ffunction-sections`)
   - Configurações específicas do MDBX (`MDBX_BUILD_FLAGS`, `MDBX_TXN_CHECKOWNER`)
   - Suporte multiplataforma (Windows: ntdll, user32)
   - Detecção de target musl
4. **Callbacks customizados**: Define tipos de inteiros para constantes MDBX

### Integração com libmdbx C
O diretório `/mdbx-sys/libmdbx/` contém o código fonte completo da biblioteca C upstream, incluindo:
- `mdbx.c`, `mdbx.h`: Core da biblioteca
- `mdbx.c++`, `mdbx.h++`: Interface C++
- Utilitários: `mdbx_chk.c`, `mdbx_copy.c`, `mdbx_dump.c`, etc.
- Sistema de build: `CMakeLists.txt`, `Makefile`, `GNUmakefile`
- Documentação: man pages, README, ChangeLog

## Características Técnicas

- **Bindings seguros**: Interface Rust type-safe sobre FFI C
- **Zero-copy**: Operações eficientes sem cópias desnecessárias
- **ORM opcional**: Sistema ORM completo com feature flag
- **Multiplataforma**: Suporte Linux, Windows, macOS
- **Performance**: Benchmarks integrados para monitoramento
- **Testing**: Suite completa de testes de integração