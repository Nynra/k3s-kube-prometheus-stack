apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
