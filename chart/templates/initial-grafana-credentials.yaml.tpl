{{- if .Values.grafana.enableIngress  }}
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
    name: {{ .Values.grafana.externalCert.remoteSecretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: username
      remoteRef:
        key: {{ .Values.grafana.externalSecret.remoteSecretName | quote }}
        property: {{ .Values.grafana.externalSecret.usernamePropertyName | quote }}
    - secretKey: password
      remoteRef:
        key: {{ .Values.grafana.externalSecret.remoteSecretName | quote }}
        property: {{ .Values.grafana.externalSecret.passwordPropertyName | quote }}
{{- end }}