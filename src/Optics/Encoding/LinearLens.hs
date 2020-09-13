module Optics.Encoding.LinearLens where

import Optics.Encoding.Class

data LinearLens s t a b = LinearLens (s -> (a, b -> t))

instance Optic LinearLens where
  (LinearLens l) >> (LinearLens m) = LinearLens $ \s ->
    let (a, u1) = l s
        (p, u2) = m a
     in (p, u1 . u2)
