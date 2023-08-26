
cd /Users/eslam/MyData/Projects/install\ k8s/vagrant/vagrant-master
vagrant up
cd ../vagrant-node1
vagrant up
cd ../vagrant-node2
vagrant up

cd ../../

ansible-playbook -i hosts --ask-pass 1-create-user.yml 
ansible-playbook -i hosts --ask-pass 2-k8s-playbook.yml 

cd vagrant/vagrant-master
vagrant ssh
