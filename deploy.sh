echo ${KUBERNETES_CA} | base64 --decode > udagram-ca.pem
echo ${KUBERNETES_CLIENT_CA} | base64 --decode > udagram-client-ca.pem
echo ${KUBERNETES_CLIENT_KEY} | base64 --decode > udagram-key.pem
kubectl config set-cluster udagram --server=${KUBERNETES_ENDPOINT} --certificate-authority=udagram-ca.pem
kubectl config set-credentials kubernetes-admin --client-certificate=udagram-client-ca.pem --client-key=udagram-key.pem
kubectl config set-context kubernetes-admin@udagram --cluster=udagram --namespace=default --user=kubernetes-admin
kubectl config use-context kubernetes-admin@udagram
kubectl rollout restart deployment users-api