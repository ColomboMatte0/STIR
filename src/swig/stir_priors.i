/*
    Copyright (C) 2018, 2020, 2021 University College London
    This file is part of STIR.

    SPDX-License-Identifier: Apache-2.0

    See STIR/LICENSE.txt for details
*/
/*!
  \file
  \brief Interface file for SWIG

  \author Kris Thielemans
  \author Robert Twyman
*/

#define TargetT stir::DiscretisedDensity<3,float>
#define elemT float

%shared_ptr(stir::GeneralisedPrior<TargetT >);

%shared_ptr(stir::PriorWithParabolicSurrogate<TargetT >);

%shared_ptr(stir::RegisteredParsingObject< stir::QuadraticPrior<elemT>,
            stir::GeneralisedPrior<TargetT >,
            stir::PriorWithParabolicSurrogate<TargetT  > >);

%shared_ptr(stir::QuadraticPrior<elemT>);

%shared_ptr(stir::RegisteredParsingObject< stir::PLSPrior<elemT>,
            stir::GeneralisedPrior<TargetT >,
            stir::GeneralisedPrior<TargetT > >);
%shared_ptr(stir::PLSPrior<elemT>);

%shared_ptr(stir::RegisteredParsingObject< stir::RelativeDifferencePrior<elemT>,
         stir::GeneralisedPrior<TargetT >,
         stir::GeneralisedPrior<TargetT > >);
%shared_ptr(stir::RelativeDifferencePrior<elemT>);

%shared_ptr(stir::RegisteredParsingObject< stir::LogcoshPrior<elemT>,
        stir::GeneralisedPrior<TargetT >,
        stir::PriorWithParabolicSurrogate<TargetT  > >);
%shared_ptr(stir::LogcoshPrior<elemT>);

%shared_ptr(stir::RegisteredParsingObject< stir::CudaRelativeDifferencePrior<elemT>,
         stir::GeneralisedPrior<TargetT >,
         stir::RelativeDifferencePrior<elemT> >);
%shared_ptr(stir::CudaRelativeDifferencePrior<elemT>);

%shared_ptr(stir::QuadraticPotential<elemT>);
%shared_ptr(stir::GibbsPrior<elemT, stir::QuadraticPotential<elemT>>);


%shared_ptr(stir::RegisteredParsingObject< stir::GibbsQuadraticPrior<elemT>,
            stir::GeneralisedPrior<TargetT >,
            stir::GibbsPrior<elemT, stir::QuadraticPotential<elemT>> >);

%shared_ptr(stir::GibbsQuadraticPrior<elemT>);


#undef elemT
#undef TargetT

%include "stir/recon_buildblock/GibbsPrior.h"
%include "stir/recon_buildblock/GibbsQuadraticPrior.h"

%include "stir/recon_buildblock/GeneralisedPrior.h"
%include "stir/recon_buildblock/PriorWithParabolicSurrogate.h"
%include "stir/recon_buildblock/QuadraticPrior.h"
%include "stir/recon_buildblock/PLSPrior.h"
%include "stir/recon_buildblock/RelativeDifferencePrior.h"
%include "stir/recon_buildblock/LogcoshPrior.h"
%include "stir/recon_buildblock/CUDA/CudaRelativeDifferencePrior.h"

#define TargetT stir::DiscretisedDensity<3,float>
#define elemT float

%template (GeneralisedPrior3DFloat) stir::GeneralisedPrior<TargetT >;
%template (PriorWithParabolicSurrogate3DFloat) stir::PriorWithParabolicSurrogate<TargetT >;

%template (RPQuadraticPrior3DFloat)
  stir::RegisteredParsingObject< stir::QuadraticPrior<elemT>,
      stir::GeneralisedPrior<TargetT >,
      stir::PriorWithParabolicSurrogate<TargetT  > >;
%template (QuadraticPrior3DFloat) stir::QuadraticPrior<elemT>;

%template (RPPLSPrior3DFloat)
  stir::RegisteredParsingObject< stir::PLSPrior<elemT>,
      stir::GeneralisedPrior<TargetT >,
      stir::GeneralisedPrior<TargetT > >;
%template (PLSPrior3DFloat) stir::PLSPrior<elemT>;

%template (RPRelativeDifferencePrior3DFloat)
    stir::RegisteredParsingObject< stir::RelativeDifferencePrior<elemT>,
       stir::GeneralisedPrior<TargetT >,
       stir::GeneralisedPrior<TargetT > >;
%template (RelativeDifferencePrior3DFloat) stir::RelativeDifferencePrior<elemT>;

%template (RPLogcoshPrior3DFloat)
stir::RegisteredParsingObject< stir::LogcoshPrior<elemT>,
        stir::GeneralisedPrior<TargetT >,
        stir::PriorWithParabolicSurrogate<TargetT  > >;
%template (LogcoshPrior3DFloat) stir::LogcoshPrior<elemT>;

%template (RPCudaRelativeDifferencePrior3DFloat)
  stir::RegisteredParsingObject< stir::CudaRelativeDifferencePrior<elemT>,
     stir::GeneralisedPrior<TargetT >,
     stir::RelativeDifferencePrior<elemT> >;
%template (CudaRelativeDifferencePrior3DFloat) stir::CudaRelativeDifferencePrior<elemT>;



%template (QuadraticPotential3DFloat) stir::QuadraticPotential<elemT>;

%nodefaultctor stir::GibbsPrior;
%ignore stir::GibbsPrior::GibbsPrior;
%template (GibbsPrior3DFloat) stir::GibbsPrior<elemT, stir::QuadraticPotential<elemT>>;

%template (RPGibbsQuadraticPrior3DFloat)
stir::RegisteredParsingObject< stir::GibbsQuadraticPrior<elemT>,
stir::GeneralisedPrior<TargetT >,
stir::GibbsPrior<elemT, stir::QuadraticPotential<elemT>> >;
%template (GibbsQuadraticPrior3DFloat) stir::GibbsQuadraticPrior<elemT>;




#undef elemT
#undef TargetT
