
cd /Users/eslam/MyData/Projects/install\ k8s/vagrantvagrant-master
vagrant destroy -f
rm -rf .vagrant

cd ../vagrant-node1
vagrant destroy -f
rm -rf .vagrant

cd ../vagrant-node2
vagrant destroy -f
rm -rf .vagrant

cd ..
