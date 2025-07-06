{{- if .Values.grafana.enableIngress }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.grafana.externalCert.name | quote }}
  namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.grafana.externalCert.remoteSecretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.grafana.externalCert.remoteSecretName | quote }}
        property: tls_crt
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.grafana.externalCert.remoteSecretName | quote }}
        property: tls_key
{{- end }}