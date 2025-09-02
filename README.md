# Luia

## MapReduce

Parallel processor between cluster nodes

```mermaid
flowchart TD
    A[Upload do Arquivo] --> B[Divisão em Chunks]
    B --> C[Nó 1]
    B --> D[Nó 2]
    B --> E[Nó N]
    C --> F[Worker 1 Processa Chunk]
    D --> G[Worker 2 Processa Chunk]
    E --> H[Worker N Processa Chunk]
    F --> I[Chunk Processado Localmente]
    G --> J[Chunk Processado Localmente]
    H --> K[Chunk Processado Localmente]
```

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
