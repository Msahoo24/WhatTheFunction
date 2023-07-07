function distmat = DistMatrix(inMat)
    % Creates a pairwise distance matrix between each element of inMat.
    % The resulting matrix is diagonal of zeros and is NxN.
    distmat = zeros(size(inMat,1),size(inMat,1));
    for i = 1:size(inMat,1)
        for k = 1:size(inMat,1)
            
            distmat(i,k) = dtwf(inMat(i,:),inMat(k,:));
            disp(sprintf('calculating object #%1.0f to object #%1.0f (%1.0f / %1.0f)'...
                                ,i,k,i,size(inMat,1)));
            
        end
    end
end

