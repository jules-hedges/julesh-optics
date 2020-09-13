module Optics.Encoding.ConcreteLens where

import Optics.Encoding.Class

data ConcreteLens s t a b = ConcreteLens {
  view :: s -> a,
  update :: s -> b -> t
}

instance Optic ConcreteLens where
  l1 >> l2 = ConcreteLens {
    view = \s -> view l2 (view l1 s),
    update = \s q -> update l1 s (update l2 (view l1 s) q)
}
