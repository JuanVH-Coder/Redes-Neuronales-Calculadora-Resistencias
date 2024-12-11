% Copyright 2016 The MathWorks, Inc.

function I = readFunctionTrainMFCC(Train)
% Resize the flowers images to the size required by the network.
I = load(Train);
I = I.MFCC;

