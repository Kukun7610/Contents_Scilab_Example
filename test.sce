clear
clc

//inputs

r_max=10
L=input('Enter the value of:')
Z=1
pqn=input('Enter the value ofn(n>1):')

num=1301

//constant
//e= Speed of light

hbar=1973
e=3.795
me=0.511e6

//potential wall
//potiential energy in electron volte eV

r_min=1e-5
r=linspace(r_min,r_max,num)
dr=r(2)-r(1)
dr2=dr^2

//Coulemb term
K=-Z*e*e
U_c=K./r

//angular momentum term
U_L=(hbar^2*L*(L+1)/(2*me))./r.^2

//Effective Potential engery
U=U_c+U_L
for cn=1:(num-2)
   U_matrix(cn,cn)=U(cn+1)
end

//Solve SCHRODNGER EQUATION
//Make Second Derivative Matreix

off=ones(num-3,1)
SD_matrix = (-2*eye(num-2,num-2)+diag(off,1)+diag(off,-1))/dr2

//Make KE Matrix
K_matrix=-hbar^2/(2*me)*SD_matrix
H_matrix=K_matrix+U_matrix

//Final Eiganvalues E_n and Eiganfinction psi_N
[e_funct,e_values]=spec(H_matrix)

//All Eiganvalues 1,2,......n where E_N<0
//Displaying Results

En=diag(e_values)
En=(En(En<0))'

disp('Quantum State Energy Eiganvalues(in eV):')
for i=1:length(En)
    printf(' %i %fn',i,En(i))
end

nl=pqn-L
printf('Energy Eiganvalue(in eV) for Quantum state no.%i:(1=%i)\n %f',n1,L,En(n1))

//Normalization of eiganfunctions
for n=1:n1
psi(:,n)=[0:e_funct(:,n);0]
area=inttrap(r,(psi(:,n).*psi(:,n))')
              psi(:,n)=psi(:,n)/sqrt(area)
prob (:,n)=psi(:,n).*psi(:,n)
end

//Ploting Results
figure(1)
xtitle('Probability Desity vs Radius')
xlabel('Radius in Armstrong')
ylable('Probability Desity per meter')
xgrid
plot(r',prob(:,nl),'b')
      
figure(2)
xtitle('Wavefunction vs Radious')
xlabel('Radious in Armstrong')
ylabel('Wavefunction')
xgrid
plot(r',psi(:,nl),'b')
      
