clc
clear
%% thermo table interpolator
P=46; %bar
T=480;
% Value wanted type
S=5;h=4;u=3;V=2;
Value_Type= h; %

Value=Pressure_Values_double_interpolator(P,T,Value_Type);

function [Value]=Pressure_Values_double_interpolator(P,T,Value_Type)
load('Thermo_Tables_Workspace.mat')
switch P
    case 40
       Thermo_Table=Superheated_H2O_V_40Bar;
       Value= Matrix_Grabber(T,Thermo_Table,Value_Type);
    case 50
       Thermo_Table=Superheated_H2O_V_50Bar;
       Value= Matrix_Grabber(T,Thermo_Table,Value_Type);
    case 80
       Thermo_Table=Superheated_H2O_V_80Bar;
       Value= Matrix_Grabber(T,Thermo_Table,Value_Type);
    case 100
       Thermo_Table=Superheated_H2O_V_100Bar;
       Value= Matrix_Grabber(T,Thermo_Table,Value_Type);



    otherwise
        X2=P;
        if P>40
            if P<50
        X1=40;
        X3=50;
        
        Thermo_Table_1=Superheated_H2O_V_40Bar;
        Thermo_Table_3=Superheated_H2O_V_50Bar;
        Y1= Matrix_Grabber(T,Thermo_Table_1,Value_Type);
        Y3= Matrix_Grabber(T,Thermo_Table_3,Value_Type);
        Value = Linear_Interpolator(X1,X2,X3,Y1,Y3);
            end
        elseif P>50
            if P<80
        X1=40;
        X3=50;
        Thermo_Table_1=Superheated_H2O_V_40Bar;
        Thermo_Table_3=Superheated_H2O_V_50Bar;
        Y1= Matrix_Grabber(T,Thermo_Table_1,Value_Type);
        Y3= Matrix_Grabber(T,Thermo_Table_3,Value_Type);
        Value = Linear_Interpolator(X1,X2,X3,Y1,Y3);
            end
        elseif P>80
            if P<100
        X1=40;
        X3=50;
        Thermo_Table_1=Superheated_H2O_V_40Bar;
        Thermo_Table_3=Superheated_H2O_V_50Bar;
        Y1= Matrix_Grabber(T,Thermo_Table_1,Value_Type);
        Y3= Matrix_Grabber(T,Thermo_Table_3,Value_Type);
        Value = Linear_Interpolator(X1,X2,X3,Y1,Y3);
            end
        end
           
      
        
end




end

function [Value]=Matrix_Grabber(T,Thermo_Table,Value_Type)
i=1;
while i<12
switch T
    case Thermo_Table(i,1)
       Value = Thermo_Table(i,Value_Type);
    otherwise
        if T>(Thermo_Table(i,1))
            if T<(Thermo_Table(i+1,1))
            X1=(Thermo_Table(i,1));
            X2=T;
            X3=(Thermo_Table(i+1,1));
            Y1=(Thermo_Table(i,Value_Type));
            Y3=(Thermo_Table(i+1,Value_Type));

      Value = Linear_Interpolator(X1,X2,X3,Y1,Y3);
            end
     
        end
      
end
    i=i+1;
end
end

function [interpolated_Value] = Linear_Interpolator(X1,X2,X3,Y1,Y3)

A=((Y3-Y1)/(X3-X1));
  B= (X2-X1);
interpolated_Value=(A*B)+Y1;

end