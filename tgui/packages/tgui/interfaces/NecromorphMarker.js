import { useBackend, useLocalState } from "../backend";
import { AnimatedNumber, Box, Button, Stack } from "../components";
import { Window } from "../layouts";

export const NecromorphMarker = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    necromorphs,
    sprites,
    biomass_invested,
    use_necroqueue,
    biomass,
  } = data;

  const [chosenNecromorph, setChosenNecromorph] = useLocalState(context, 'picked_necromorph');

  return (
    <Window
      width={700}
      height={400}>
      <Window.Content>
        <Stack fill>
          {chosenNecromorph ? (
            <Stack.Item grow>
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
                  <Stack fill>
                    <Stack.Item grow />
                    <Stack.Item>
                      Biomass to unlock: <AnimatedNumber
                        value={biomass_invested} />
                      /{chosenNecromorph.biomass_required}
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          ) : (
            <Stack.Item grow>
              Test
            </Stack.Item>
          )}
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
