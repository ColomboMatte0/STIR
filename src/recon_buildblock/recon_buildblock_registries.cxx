//
//
/*
    Copyright (C) 2000- 2009, Hammersmith Imanet Ltd
    This file is part of STIR.

    SPDX-License-Identifier: Apache-2.0

    See STIR/LICENSE.txt for details
*/
/*!
  \file
  \ingroup recon_buildblock
  \brief File that registers all stir::RegisterObject children in recon_buildblock
  \author Kris Thielemans
*/
#include "stir/DiscretisedDensity.h"
#include "stir/recon_buildblock/PoissonLogLikelihoodWithLinearModelForMeanAndProjData.h"
#include "stir/recon_buildblock/PoissonLogLikelihoodWithLinearModelForMeanAndListModeDataWithProjMatrixByBin.h"

#include "stir/recon_buildblock/FilterRootPrior.h"
#include "stir/DataProcessor.h"
#include "stir/recon_buildblock/QuadraticPrior.h"
#include "stir/recon_buildblock/GibbsQuadraticPrior.h"
#include "stir/recon_buildblock/PLSPrior.h"
#include "stir/recon_buildblock/RelativeDifferencePrior.h"
#include "stir/recon_buildblock/LogcoshPrior.h"

#include "stir/recon_buildblock/ProjMatrixByBinUsingRayTracing.h"
#include "stir/recon_buildblock/ProjMatrixByBinUsingInterpolation.h"
#include "stir/recon_buildblock/ProjMatrixByBinFromFile.h"
#include "stir/recon_buildblock/ProjMatrixByBinSPECTUB.h"
#include "stir/recon_buildblock/ProjMatrixByBinPinholeSPECTUB.h"

#include "stir/recon_buildblock/ForwardProjectorByBinUsingProjMatrixByBin.h"
#include "stir/recon_buildblock/ForwardProjectorByBinUsingRayTracing.h"

#include "stir/recon_buildblock/BackProjectorByBinUsingProjMatrixByBin.h"
#include "stir/recon_buildblock/BackProjectorByBinUsingInterpolation.h"
#include "stir/recon_buildblock/PresmoothingForwardProjectorByBin.h"
#include "stir/recon_buildblock/PostsmoothingBackProjectorByBin.h"

#include "stir/recon_buildblock/ProjectorByBinPairUsingProjMatrixByBin.h"
#include "stir/recon_buildblock/ProjectorByBinPairUsingSeparateProjectors.h"

#include "stir/recon_buildblock/TrivialBinNormalisation.h"
#include "stir/recon_buildblock/ChainedBinNormalisation.h"
#include "stir/recon_buildblock/BinNormalisationFromProjData.h"
#include "stir/recon_buildblock/BinNormalisationSPECT.h"
#include "stir/recon_buildblock/BinNormalisationFromAttenuationImage.h"

#include "stir/modelling/ParametricDiscretisedDensity.h"
#include "stir/DynamicDiscretisedDensity.h"
#include "stir/recon_buildblock/PoissonLogLikelihoodWithLinearKineticModelAndDynamicProjectionData.h"
#include "stir/recon_buildblock/PoissonLogLikelihoodWithLinearModelForMeanAndGatedProjDataWithMotion.h"

#include "stir/analytic/FBP2D/FBP2DReconstruction.h"
#include "stir/analytic/FBP3DRP/FBP3DRPReconstruction.h"

#include "stir/OSMAPOSL/OSMAPOSLReconstruction.h"
#include "stir/KOSMAPOSL/KOSMAPOSLReconstruction.h"
#include "stir/OSSPS/OSSPSReconstruction.h"

#ifdef HAVE_LLN_MATRIX
#  include "stir/recon_buildblock/BinNormalisationFromECAT7.h"
#endif
#include "stir/recon_buildblock/BinNormalisationFromECAT8.h"

#ifdef HAVE_HDF5
#  include "stir/recon_buildblock/BinNormalisationFromGEHDF5.h"
#endif

#include "stir/recon_buildblock/FourierRebinning.h"

#ifdef STIR_WITH_NiftyPET_PROJECTOR
#  include "stir/recon_buildblock/NiftyPET_projector/ForwardProjectorByBinNiftyPET.h"
#  include "stir/recon_buildblock/NiftyPET_projector/BackProjectorByBinNiftyPET.h"
#  include "stir/recon_buildblock/NiftyPET_projector/ProjectorByBinPairUsingNiftyPET.h"
#endif

#ifdef STIR_WITH_CUDA
#  include "stir/recon_buildblock/CUDA/CudaRelativeDifferencePrior.h"
#endif

#ifdef STIR_WITH_Parallelproj_PROJECTOR
#  include "stir/recon_buildblock/Parallelproj_projector/ForwardProjectorByBinParallelproj.h"
#  include "stir/recon_buildblock/Parallelproj_projector/BackProjectorByBinParallelproj.h"
#  include "stir/recon_buildblock/Parallelproj_projector/ProjectorByBinPairUsingParallelproj.h"
#endif

//#include "stir/IO/InputFileFormatRegistry.h"

START_NAMESPACE_STIR
// static RegisterInputFileFormat<InterfileProjMatrixByBinInputFileFormat> idummy0(0);

static PoissonLogLikelihoodWithLinearModelForMeanAndProjData<DiscretisedDensity<3, float>>::RegisterIt dummy1;
static PoissonLogLikelihoodWithLinearModelForMeanAndListModeDataWithProjMatrixByBin<DiscretisedDensity<3, float>>::RegisterIt
    dummy2;

static FilterRootPrior<DiscretisedDensity<3, float>>::RegisterIt dummy4;
static QuadraticPrior<float>::RegisterIt dummy5;
static GibbsQuadraticPrior<float>::RegisterIt dummyGibbsQuadratic;
static PLSPrior<float>::RegisterIt dummyPLS;
static RelativeDifferencePrior<float>::RegisterIt dummyRelativeDifference;
static LogcoshPrior<float>::RegisterIt dummyLogcosh;

static ProjMatrixByBinUsingRayTracing::RegisterIt dummy11;
static ProjMatrixByBinUsingInterpolation::RegisterIt dummy12;
static ProjMatrixByBinFromFile::RegisterIt dumy13;
static ProjMatrixByBinSPECTUB::RegisterIt dumy14;
static ProjMatrixByBinPinholeSPECTUB::RegisterIt dummy15;

static ForwardProjectorByBinUsingProjMatrixByBin::RegisterIt dummy31;
static ForwardProjectorByBinUsingRayTracing::RegisterIt dummy32;
static PostsmoothingBackProjectorByBin::RegisterIt dummy33;

static BackProjectorByBinUsingProjMatrixByBin::RegisterIt dummy51;
static BackProjectorByBinUsingInterpolation::RegisterIt dummy52;
static PresmoothingForwardProjectorByBin::RegisterIt dummy53;

static ProjectorByBinPairUsingProjMatrixByBin::RegisterIt dummy71;
static ProjectorByBinPairUsingSeparateProjectors::RegisterIt dummy72;

static TrivialBinNormalisation::RegisterIt dummy91;
static ChainedBinNormalisation::RegisterIt dummy92;
static BinNormalisationFromProjData::RegisterIt dummy93;
static BinNormalisationFromAttenuationImage::RegisterIt dummy94;
static BinNormalisationSPECT::RegisterIt dummy95;
static PoissonLogLikelihoodWithLinearKineticModelAndDynamicProjectionData<ParametricVoxelsOnCartesianGrid>::RegisterIt Dummyxxx;
static PoissonLogLikelihoodWithLinearModelForMeanAndGatedProjDataWithMotion<DiscretisedDensity<3, float>>::RegisterIt Dummyxxxzz;

static FBP2DReconstruction::RegisterIt dummy601;
static FBP3DRPReconstruction::RegisterIt dummy602;

static OSMAPOSLReconstruction<DiscretisedDensity<3, float>>::RegisterIt dummy603;
static KOSMAPOSLReconstruction<DiscretisedDensity<3, float>>::RegisterIt dummyK;
static OSSPSReconstruction<DiscretisedDensity<3, float>>::RegisterIt dummy604;

static OSMAPOSLReconstruction<ParametricVoxelsOnCartesianGrid>::RegisterIt dummyOSMAPOSLPVC;
static OSSPSReconstruction<ParametricVoxelsOnCartesianGrid>::RegisterIt dummyOSSPSPVC;

#ifdef STIR_WITH_NiftyPET_PROJECTOR
static ForwardProjectorByBinNiftyPET::RegisterIt gpu_fwd;
static BackProjectorByBinNiftyPET::RegisterIt gpu_bck;
static ProjectorByBinPairUsingNiftyPET::RegisterIt gpu_pair;
#endif

#ifdef STIR_WITH_CUDA
static CudaRelativeDifferencePrior<float>::RegisterIt gpu_rdp;
#endif

#ifdef STIR_WITH_Parallelproj_PROJECTOR
static ForwardProjectorByBinParallelproj::RegisterIt parallelproj_fwd;
static BackProjectorByBinParallelproj::RegisterIt parallelproj_bck;
static ProjectorByBinPairUsingParallelproj::RegisterIt parallelproj_pair;
#endif

#ifdef HAVE_LLN_MATRIX
START_NAMESPACE_ECAT
START_NAMESPACE_ECAT7
static BinNormalisationFromECAT7::RegisterIt dummy102;
END_NAMESPACE_ECAT7
END_NAMESPACE_ECAT
#endif

START_NAMESPACE_ECAT
static BinNormalisationFromECAT8::RegisterIt dummy103;
END_NAMESPACE_ECAT

#ifdef HAVE_HDF5
static GE::RDF_HDF5::BinNormalisationFromGEHDF5::RegisterIt dummy104;
#endif

static FourierRebinning::RegisterIt dummyFORE;

END_NAMESPACE_STIR
