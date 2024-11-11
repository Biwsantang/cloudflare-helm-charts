{{/*
Expand the name of the chart.
*/}}
{{- define "cloudflare-tunnel.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloudflare-tunnel.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create tunnelSecret secret name
*/}}
{{- define "cloudflare-tunnel.generate.tunnelsecret-secretname" -}}
{{- printf "%s-tunnelSecret-secretName" (include "cloudflare-tunnel.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create cert secret name
*/}}
{{- define "cloudflare-tunnel.generate.cert-secretname" -}}
{{- printf "%s-cert-secretName" (include "cloudflare-tunnel.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cloudflare-tunnel.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cloudflare-tunnel.labels" -}}
helm.sh/chart: {{ include "cloudflare-tunnel.chart" . }}
{{ include "cloudflare-tunnel.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cloudflare-tunnel.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cloudflare-tunnel.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
