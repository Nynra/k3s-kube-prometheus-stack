{{- if .Values.grafana.enableIngress }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: grafana-ingress
  namespace: {{ .Values.prometheus.namespace }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "2"
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`{{ .Values.grafana.ingressUrl }}`)
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
    secretName: {{ .Values.grafana.externalCert.name }}
{{- end }}