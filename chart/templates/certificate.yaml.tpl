{{- if .Values.enabled }}{{- if .Values.grafanaIngress.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.grafanaIngress.certName | quote }}
  namespace: {{ .Values.namespace.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
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
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.grafanaIngress.externalCert.secretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.grafanaIngress.externalCert.secretName | quote }}
        property: tls_crt
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.grafanaIngress.externalCert.secretName | quote }}
        property: tls_key
{{- end }}{{- end }}