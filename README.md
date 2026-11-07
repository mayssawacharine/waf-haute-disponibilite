# Haute disponibilité basée sur un WAF Open Source

Projet réalisé à TEK-UP, matière Audit.
Réalisé par Mayssa Wacharine. Encadrant : M. Mohamed Ali Mejri.

## Objectif
Protéger une application web contre les attaques (SQLi, XSS, path traversal) avec un WAF Open Source, sans que la panne d'un composant n'interrompe le service.

## Architecture
Client -> VIP (Keepalived) -> waf01 / waf02 (Nginx + ModSecurity + OWASP CRS) -> app01 / app02

| Machine | IP | Rôle |
|---|---|---|
| waf01 | 192.168.56.11 | WAF MASTER |
| waf02 | 192.168.56.12 | WAF BACKUP |
| app01 | 192.168.56.21 | Serveur applicatif |
| app02 | 192.168.56.22 | Serveur applicatif |
| VIP | 192.168.56.100 | Adresse virtuelle |

## Technologies
RHEL 9.8, Nginx 1.20, ModSecurity v3, OWASP CRS, Keepalived (VRRP), TLS 1.2 et 1.3, VMware.

## Contenu du dépôt
- `docs/` : rapport et présentation
- `configs/` : configurations Nginx, ModSecurity et Keepalived
- `scripts/` : script de mesure de la bascule
- `images/` : captures d'écran

## Règles OWASP CRS
Non incluses dans le dépôt :
`git clone https://github.com/coreruleset/coreruleset /etc/nginx/modsec/crs`

## Résultats
- Attaques SQLi, XSS et path traversal bloquées (403 Forbidden)
- Panne d'un serveur applicatif : service continu
- Panne du WAF actif : bascule de la VIP en environ 5,3 secondes, protection maintenue

## Remarques
Laboratoire sur machines virtuelles. Certificat auto-signé, clé privée non versionnée. Le mot de passe Keepalived a été remplacé par `CHANGE_ME`.