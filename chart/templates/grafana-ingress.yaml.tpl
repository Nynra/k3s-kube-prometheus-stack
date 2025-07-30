{{- if .Values.enabled }}{{- if .Values.grafanaIngress.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: grafana-ingress
  namespace: {{ .Values.namespace.name | quote }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "2"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
    # Grafana Ingress annotations
    {{- if .Values.grafanaIngress.commonAnnotations }}
    {{- toYaml .Values.grafanaIngress.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Grafana Ingress labels
    {{- if .Values.grafanaIngress.commonLabels }}
    {{- toYaml .Values.grafanaIngress.commonLabels | nindent 4 }}
    {{- end }}
spec:
  entryPoints:
    - {{ .Values.grafanaIngress.entrypoint | default "websecure" | quote }}
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
    secretName: {{ .Values.grafanaIngress.certName | quote }}
{{- end }}{{- end }}