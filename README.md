
LWTW API
=====================
=============================================================================

Executando
-------------------------------------------------------------------------------

  

Se você possui o docker instalado, extraia ou clone este repositório e em seguida execute este comando na raiz do repositório:

```
docker-compose up -d
```

A **API** ira esta ouvindo em [http://localhost:4567](http://localhost:4567).


-------------------------------------------------------------------------------
Stack
-------------------------------------------------------------------------------

A ideia era manter um stack puro e simples, tentando alcancar esse estado de "*apenas a biblioteca padrão da linguagem*", mas sem perder a produtividade.

###  API
Queria criar uma API enxuta e simples, evitando todas as complexidades que um monolito poderia me trazer em um projeto com um ciclo de vida tão curto. E com o Docker eu poderia entregar em qualquer plataforma sem prejuizo ou diferenca na instalação. Entre *Python* com *Flask*, *Ruby* com *Sinatra* e *NodeJS* com *Express.JS*, *Sinatra* parecia ser a opção mais enxuta. Alem disso, a Locaweb utiliza majoritariamente *Ruby* e isso tambem pesava a favor. Conclusão: a *API* foi construida com apenas **Ruby** e **Sinatra**, e para testes **RSpec**.

### Front-end
Seguindo a proposta de simplicidade, criei apenas um html como frontend, usando apenas **Bootstrap** e **jQuery**. A comunicação com a *API* se deu por *HTTP/JSON*, como um cliente comum. O html é servido pelo backend na rota raiz.