```yaml
name: ux-expert
categoria: domini
depen_de: []
aporta_agents:
  - ux-expert
```

# Servei: ux-expert

Revisió i validació d'experiència d'usuari per a projectes amb interfície. Avalua pantalles, fluxos i fricció. No produeix implementació — revisa output del worker i emet veredicte UX.

## Quan activar

- El projecte té component de UI/interfície d'usuari
- Cal validació UX integrada al circuit de decisions (no auditoria puntual)
- La qualitat d'ús és un criteri de DoD

## Fitxers que aporta

| Fitxer | Rol |
|--------|-----|
| `agents/ux-expert.md` | Agent de revisió UX |

## Dependències

**Requereix activat:** (cap)
**Llegeix de:** captures, codi UI, especificacions de la tasca
**Escriu a:** veredicte UX inline a la tasca (no fitxer separat per defecte)

## Integració als processos

Un cop activat, s'injecta automàticament al pas 6 d'`executar-tasca.md`: el worker entrega i `@ux-expert` revisa en paral·lel amb el PM.

Al `CLAUDE.md` del projecte:
```
## UX actiu
@ux-expert revisa en paral·lel al pas 6 d'executar-tasca per a qualsevol tasca que toqui UI.
```

## Activació manual

1. Copiar `agents/ux-expert.md` a `.claude/agents/ux-expert.md`
2. Declarar al `CLAUDE.md` del projecte (bloc UX actiu, vegeu dalt)
