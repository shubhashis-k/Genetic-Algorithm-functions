IndLength=20;
PopLength=10;
generation=100;
runEnd=1;
FitnessRun=zeros(runEnd,1);
Lb=-5.12;
Ub=5.12;
for run = 1:runEnd
    InitPop=round(rand(PopLength,IndLength));
    CurrentPop=InitPop;
    SelectedPop=zeros(PopLength,IndLength);
    Fitness=zeros(PopLength,1);
    DecVal=zeros(PopLength,1);
    FitnessStore=zeros(generation,1);
    xval=zeros(generation,1);
%%Fitness Value Calculation%%%%%%
    for gen=1:generation
        for i=1:PopLength
            for j=IndLength:-1:1%%convert binary to decimal
                Fitness(i)= Fitness(i) + CurrentPop(i,j)*(2^(IndLength-j));
            end
            Fitness(i)=Lb+Fitness(i)*((Ub-Lb)/((2^IndLength)-1));%%put value into the valid region that means between upper and lower bound
            DecVal(i)=Fitness(i);%store the decimal value within the valid region
            Fitness(i)=Fitness(i)^2;%%sqare function
        end
        
        
        
        
%%Tournament Selection %%%%%%%%%%
        Matepool=randi(PopLength,PopLength,2);%%select two individuals randomly for tournament and chooose the one with less fitness value
        %% number of tournament is equal to the number of population size
        for i=1:PopLength
            if Fitness(Matepool(i,1))<= Fitness(Matepool(i,2))
                SelectedPop(i,1:IndLength)=CurrentPop(Matepool(i,1),1:IndLength);
            else
                SelectedPop(i,1:IndLength)=CurrentPop(Matepool(i,2),1:IndLength);
            end
        end
        
        
        
 
%%Three parent Crossover%%%

SelectedForCrossover = zeros(PopLength,3);
for i=1:1:3
    SelectedForCrossover(:,i) = randperm(PopLength);
end

crossoverPossibilities = rand(PopLength,1);
crossoverchance = .25;

for(i=1:1:PopLength)
    if(crossoverPossibilities(i) < crossoverchance)
        for(j = 1:1:IndLength)            
            gene1 = SelectedForCrossover(i,1);
            gene2 = SelectedForCrossover(i,2);
            gene3 = SelectedForCrossover(i,3);
            if(SelectedPop(gene1,j) == SelectedPop(gene2,j))
                SelectedPop(gene3,j) = SelectedPop(gene1,j);
            end
        end
    end
end
    







        
        
        
%%%%%Flipping mutation%%%%
        Mutation=rand(PopLength,IndLength);
        for i=1:PopLength
            for j=1:IndLength
                if Mutation(i,j)<0.01
                    SelectedPop(i,j)=1-SelectedPop(i,j);
                end
            end
        end
        
        
        
        
        CurrentPop=SelectedPop;%%next generation population
        [FitnessStore(gen,1),x]=min(Fitness(:));%minimum fitness value in this generation
        xval(gen,1)=DecVal(x);%decimal value of the individual that have minimum fitness value
        for i=1:PopLength
            Fitness(i)=0;
        end
    end
FitnessRun(run,1)=FitnessStore(generation-1,1)
xval(gen-1,1)
end
mean(FitnessRun(:,:));