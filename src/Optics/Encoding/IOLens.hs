module Optics.Encoding.IOLens where

-- Extremely evil optic encoding that I descriped in a Twitter thread here:
-- https://twitter.com/_julesh_/status/1303412643412180992

import Data.IORef
import Control.Monad ((>=>))
import Optics.Encoding.Class

data IOLens s t a b = IOLens {
  view :: s -> IO a,
  update :: b -> IO t
}

instance Optic IOLens where
  l >> m = IOLens {
    view = view l >=> view m,
    update = update m >=> update l
}

mkIOLens :: (s -> a) -> (s -> b -> t) -> s -> IO (IOLens s t a b)
mkIOLens f g s = do p <- newIORef s
                    return $ IOLens {
                      view = \s -> do writeIORef p s
                                      return (f s),
                      update = \b -> do s <- readIORef p
                                        return (g s b)
                    }
