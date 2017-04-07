function [output]=filter_2sides_highpass(input)

fd=filter(cheb_highpass,input);

nnum=length(input);  
for i=1:length(input);
    fd2(i)=fd(nnum);   
    nnum=nnum-1;
end

fd3=filter(cheb_highpass,fd2);
nnum=length(input);    
for i=1:length(input);
    output(i)=fd3(nnum);
    nnum=nnum-1;
end
    