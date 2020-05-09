clear
clc

//INPUTS

r_max=7                          //maximum radious(Range) Default=l Armstrong(A)
L=input('enter the value of l:') //Orbital angular momentum quantum no
Z=1                              //Atomic no. or total charge
pqn=input('enter the value of n(n>l):') //Principal quantum number,
                                        //for ground state pqn=1
                                        //1st Excited state pqn
num=1501                         //number of odd data points Default 1501

//CONSTANTS
//c=Speed of light

hbar=1973
me=940e6
D=0.755501
r0=0.131349
a=1.44

//POTENTIAL WELL
//potential energy in electon volts(eV)

r_min=1e-5                     //Default 1e-5 in Armstrong(A)
r=linspace(r_min,r_max,num)
dr=r(2)-r(1)
dr2=dr^2

r1=(r-(r0*ones(1,num)))./r    //Making r1 matrix

//Morse Potential
K=D*(exp(-2*a.*r1)-2*exp(-a.*r1))
U_c=K

//Angular momentum term
U_L=(hbar^2*L*(L+1)/(2*me))./r.^2

//Effective potential energy
U=U_c+U_L
for cn=1:(num-2)
    U_matrix(cn,cn)=U(cn+1)
end

//SOLVE SCHRODINGER EQUATION
//MAke 2ndary Derivative Matrix
off=ones(num-3,1)
SD_matrix=(-2*eye(num-2,num-2)+diag(off,1)+diag(off,-1))/dr2

//Make KE Matrix
K_matrix=-hbar^2/(2*me)*SD_matrix

//Make Hamiltonian matrix
H_matrix=K_matrix+U_matrix

//Find Eigenvalues E_n and Eigenfunction psi_N
[e_funct,e_values]=spec(H_matrix)

//All Eigenvalues 1,2,...n where E_N<0
//DISPLAYING ReSULTS(Eigenvalues)
En=diag(e_values)
En=(En(En<0))'

disp('Quantum state, Energy Eigenvalues(in eV):')
for i=1:length(En)
printf('%i %f\n',i,En(i))
end
nl=pqn-L
printf('Energy Eigenvalue(in eV) for Quntum stae no.%i:(l=%i)\n%f',nl,L,En(nl))

//Normalisation of eigenfunctions
for n=1:nl
    psi(:,n)=[0;e_funct(:,n);0]
    area=inttrap(r,(psi(:,n).*psi(:,n))')
    psi(:,n)=psi(:,n)/sqrt(area)
    prob(:,n)=psi(:,n).*psi(:,n)
end

//PLOTTING RESULTS(Eigenfunctions and probability)

figure(1)
xtitle('probability density vs radius by C-RAY')
xlabel('Radius in Armstrong')
ylabel('Probabilty Density per meter')
xgrid
plot(r',prob(:,nl),'b')

figure(2)
xtitle('Wave function vs radius by C-RAY')
xlabel('Radius in Armstrong')
ylabel('Wavefunction')
xgrid
plot(r',psi(:,nl),'b')

