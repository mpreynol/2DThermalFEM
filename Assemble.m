classdef Assemble < handle
    % Assembly Class consists of static methods to assemble Stiffness
    % Matrix and Force Vectors from a mesh collection
    
    properties
    end
    
    methods(Static)
        function [K,f]= buildFromMesh(Mesh,n)
           K=zeros(n,n);
           f=zeros(n,1);
           for kitten=1:length(Mesh)
                dof=Mesh(kitten).dof; % Use dof array as logical indexer
                K(dof,dof)=K(dof,dof)+Mesh(kitten).K;
                f(dof)=f(dof)+Mesh(kitten).f;    
           end
        end
        function [ufull] = reAssembleUnknowns(ureduced,BE)
            L=BE==-inf;
            ufull=zeros(length(BE),1);
            counter=1;
            for i=1:length(BE)
               if L(i)==1
                   ufull(i)=ureduced(counter);
                   counter=counter+1;
               else
                   ufull(i)=BE(i);
               end
            end
        end
        function [Z]=buildSurface(X,Y,NN)
            Z=zeros(size(X,1),size(X,2));
            for i =1: length(X)
                for j=1: length(Y)
                    for k=1:length(NN)
                        if (NN(k,2)==X(i,j) && NN(k,3)==Y(i,j))
                            Z(i,j)=NN(k,4);
                        end
                    end
                end
            end
        end
    end
end
    


