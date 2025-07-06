{{- if .Values.grafanaIngress.enabled }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.kube-prometheus-stack.grafana.admin.existingSecret }}
  namespace: {{ .Values.namespace | quote}}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.grafanaIngress.externalCert.remoteSecretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: username
      remoteRef:
        key: {{ .Values.grafanaIngress.externalSecret.remoteSecretName | quote }}
        property: {{ .Values.grafanaIngress.externalSecret.usernamePropertyName | quote }}
    - secretKey: password
      remoteRef:
        key: {{ .Values.grafanaIngress.externalSecret.remoteSecretName | quote }}
        property: {{ .Values.grafanaIngress.externalSecret.passwordPropertyName | quote }}
{{- end }}