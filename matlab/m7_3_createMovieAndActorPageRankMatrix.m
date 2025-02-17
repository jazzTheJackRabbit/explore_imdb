fileID = fopen('movieActorPageRankMatrix.txt','w');
fclose(fileID);

movieActorPageRankMatrix = cell(3000000,1);
totalNumberOfMovies = length(keys(movieIndexDictionary));
totalNumberOfActorsFromRList = length(r_actorNameVector);
for movieIndex = (1:totalNumberOfMovies)    
    actorsListForCurrentMovie = movieActorsMatrix{movieIndex};
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %DO NOT IGNORE THE ACTORS THAT WONT BE THERE!!!!!!
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pageRankForAllActorsInMovie = zeros(1,length(actorsListForCurrentMovie));
    outputStringForMovie = '';
    for aIndex = (1:length(actorsListForCurrentMovie))
        %Find the actor's name in the MATLAB list
        actorIndex = actorsListForCurrentMovie(aIndex);
        actorName = actorNameVector(actorIndex); actorName = actorName{1};
        
        if(isKey(r_actorIndexDictionary,actorName))
            %If actor is there in the R list
            indexInRList = r_actorIndexDictionary(actorName);
            pageRankForActor = r_ActorPageRankVector{indexInRList};
            pageRankForAllActorsInMovie(aIndex) = pageRankForActor;            
        else
            %If actor is NOT there in the R list
            %IGNORE
        end                
    end
    pageRankForAllActorsInMovie = sort(pageRankForAllActorsInMovie,'descend');           
    movieActorPageRankMatrix{movieIndex} = pageRankForAllActorsInMovie;
    dlmwrite('movieActorPageRankMatrix.txt',pageRankForAllActorsInMovie,'-append');        
    if(mod(movieIndex,1000) == 0)
        disp(strcat(num2str(movieIndex),':',movieTitleVector{movieIndex}));
    end
end