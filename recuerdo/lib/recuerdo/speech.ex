defmodule Speech do
  def passage("preamble") do
    """
    When in the Course of human events, it becomes necessary for one people to
    dissolve the political bands which have connected them with another, and to
    assume among the powers of the earth, the separate and equal station to
    which the Laws of Nature and of Nature's God entitle them, a decent respect
    to the opinions of mankind requires that they should declare the causes
    which impel them to the separation.
    """
  end

  def passage("macbeth") do
    """
    Tomorrow, and tomorrow, and tomorrow,
    Creeps in this petty pace from day to day,
    To the last syllable of recorded time;
    And all our yesterdays have lighted fools
    The way to dusty death. Out, out, brief candle!
    Life's but a walking shadow, a poor player,
    That struts and frets his hour upon the stage,
    And then is heard no more. It is a tale
    Told by an idiot, full of sound and fury,
    Signifying nothing.
    """
  end
end