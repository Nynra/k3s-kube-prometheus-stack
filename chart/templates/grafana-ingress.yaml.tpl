{{- if .Values.grafanaIngress.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: grafana-ingress
  namespace: {{ .Values.namespace }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "2"
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`{{ .Values.grafanaIngress.ingressUrl }}`)
      kind: Rule
      services:
        - name: prometheus-grafana
          port: 80
          # sticky:
          #   cookie:
          #     httpOnly: true
          #     name: grafana
          #     secure: true
          #     sameSite: none
  tls:
    secretName: {{ .Values.grafanaIngress.externalCert.name }}
{{- end }}