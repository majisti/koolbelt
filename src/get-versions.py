import os
import json

tools = {
    'dotcl': os.popen("doctl version | awk 'NR==1 {print $3}' | cut -d'-' -f 1 | tr -d '\n'").read(),
	'helm': os.popen("helm version --template '{{ .Version }}' | cut -c2- | tr -d '\n'").read(),
	'kubectl': os.popen("kubectl version --short --client | awk '{print $3}' | cut -c2- | tr -d '\n'").read(),
	'argocd': os.popen("argocd version --client --short | awk '{print $2}' | cut -d'+' -f 1 | cut -c2- | tr -d '\n'").read(),
	'fluxcd': os.popen("fluxctl version | tr -d '\n'").read(),
}

with open('versions.json', 'w') as outfile:
    json.dump(tools, outfile)

