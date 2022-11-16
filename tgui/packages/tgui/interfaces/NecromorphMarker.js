import { useBackend, useLocalState } from "../backend";
import { Box, Button, ProgressBar, Stack } from "../components";
import { Window } from "../layouts";

export const NecromorphMarker = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    necromorphs,
    sprites,
    use_necroqueue,
    biomass,
    biomass_invested,
    signal_biomass,
    signal_biomass_percent,
  } = data;

  const [chosenNecromorph, setChosenNecromorph] = useLocalState(context, 'picked_necromorph');

  return (
    <Window
      width={700}
      height={400}>
      <Window.Content>
        <Stack fill>
          <Stack.Item grow>
            {chosenNecromorph ? (
              <Stack vertical fill>
                <Stack.Item grow>
                  <Stack>
                    <Stack.Item>
                      <Box className={"MarkerIconFrame necromorphs"+sprites[chosenNecromorph.name]+" "+chosenNecromorph.name} />
                    </Stack.Item>
                    <Stack.Item>
                      <Box bold>{chosenNecromorph.name}</Box>
                      {chosenNecromorph.desc}
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Stack vertical fill>
                    <Stack.Item>
                      <ProgressBar value={1} ranges={{ "red": [0, 1] }}>
                        <Box textAlign="center">
                          Marker Biomass | {biomass}
                        </Box>
                      </ProgressBar>
                    </Stack.Item>
                    <Stack.Item>
                      <Stack fill>
                        <Stack.Item>
                          <Button onClick={() => act('change_signal_biomass', { "biomass": -100 })}>-100</Button>
                          <Button onClick={() => act('change_signal_biomass', { "biomass": -10 })}>-10</Button>
                          <Button onClick={() => act('change_signal_biomass', { "biomass": -1 })}>-1</Button>
                        </Stack.Item>
                        <Stack.Item grow>
                          <ProgressBar value={1} ranges={{ "purple": [0, 1] }}>
                            <Box textAlign="center">
                              Signal Biomass | {signal_biomass}
                            </Box>
                          </ProgressBar>
                        </Stack.Item>
                        <Stack.Item>
                          <Button onClick={() => act('change_signal_biomass', { "biomass": +1 })}>+1</Button>
                          <Button onClick={() => act('change_signal_biomass', { "biomass": +10 })}>+10</Button>
                          <Button onClick={() => act('change_signal_biomass', { "biomass": +100 })}>+100</Button>
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                {
                  /*
                <Stack.Item>
                  <Stack fill>
                    <Stack.Item grow />
                    <Stack.Item>
                      Biomass to unlock: <AnimatedNumber
                        value={biomass_invested} />
                      /{chosenNecromorph.biomass_required}
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                    */
                }
              </Stack>
            ) : (
              <Box>Test</Box>
            )}
          </Stack.Item>
          <Stack.Item grow="0.3">
            <Stack vertical fill>
              <Stack.Item grow>
                {necromorphs.map((necromorph, i) => (
                  <Button
                    fluid key={necromorph.name}
                    fontSize={1.5}
                    selected={chosenNecromorph?.name === necromorph.name}
                    onClick={() => setChosenNecromorph(necromorph)}>
                    {necromorph.name}
                  </Button>
                ))}
              </Stack.Item>
              <Stack.Item>
                <Button.Checkbox
                  bold
                  fluid
                  textAlign="center"
                  checked={use_necroqueue}
                  onClick={() => act('switch_necroqueue')}>
                  Use necroqueue
                </Button.Checkbox>
                <Button
                  bold
                  fluid
                  fontSize={2.5}
                  textAlign="center"
                  disabled={!chosenNecromorph}
                  onClick={() => act('spawn_necromorph', { "class": chosenNecromorph.type })}>
                  Spawn
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
