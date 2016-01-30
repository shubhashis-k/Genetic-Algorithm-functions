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
        
        
        
        
        
%%N point Crossover%%%
n = 2;
crossoverPoints = zeros(10,n+2);
crossoverPoints(:,1) = 1;
crossoverPoints(:,n+2) = PopLength;
crossoverPoints(:,2:n+1) = sort(randi([2,PopLength-1],PopLength,n),2);
SelectedForCrossover = randi([1,PopLength],PopLength,2);

crossoverPossibilities = rand(PopLength,1);
crossoverchance = .25;

for(i=1:1:PopLength)
    if(crossoverPossibilities(i) < crossoverchance)
        for(j = 2:1:n+2)
            gene1 = SelectedForCrossover(i,1);
            gene2 = SelectedForCrossover(i,2);
            pos1 = crossoverPoints(i,j-1);
            pos2 = crossoverPoints(i,j);
            [SelectedPop(gene1,pos1:pos2), SelectedPop(gene2,pos1:pos2)] = deal(SelectedPop(gene2,pos1:pos2), SelectedPop(gene1,pos1:pos2));
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