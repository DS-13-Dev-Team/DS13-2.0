import { round } from '../../common/math';
import { useBackend } from '../backend';
import { Button, Divider, Stack } from '../components';
import { Window } from '../layouts';

export const PreySightings = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    world_time,
    sightings,
  } = data;

  /*

  */

  return (
    <Window
      width={530}
      height={400}
      title="Prey Sightings">
      <Window.Content>
        <Stack>
          <Stack.Item grow={0.1}>
            Eyes
          </Stack.Item>
          <Stack.Item>
            |
          </Stack.Item>
          <Stack.Item grow={0.425}>
            Last Sightings
          </Stack.Item>
          <Stack.Item grow>
            | Location
          </Stack.Item>
        </Stack>
        <Divider />
        {sightings?.map((sight, i) => (
          <>
            <Stack key={sight.ref}>
              <Stack.Item>
                Eye {i+1}
              </Stack.Item>
              <Stack.Item>
                |
              </Stack.Item>
              <Stack.Item grow={0.5}>
                {getLastSighting(sight.time, world_time)}
              </Stack.Item>
              <Stack.Item grow>
                | {sight.coords}
              </Stack.Item>
              <Stack.Item>
                <Button onClick={() => act('jump', { 'eye_ref': sight.ref })}>Jump</Button>
              </Stack.Item>
            </Stack>
            <Divider hidden />
          </>
        ))}
      </Window.Content>
    </Window>
  );
};

const getLastSighting = (sighting_time, world_time) => {
  if (!sighting_time) {
    return "Haven't seen anything";
  }
  let delta_time = world_time-sighting_time;
  const SECONDS = 10;
  const MINUTES = SECONDS*60;
  const HOURS = MINUTES*60;
  let string;
  if (delta_time < 10*SECONDS) {
    string = "Now! ";
  }
  else if (delta_time < 1*MINUTES) {
    string = round(delta_time/SECONDS);
    string += " seconds ago";
  }
  else if (delta_time < 1*HOURS) {
    string = round(delta_time/MINUTES);
    string += " minutes ago";
  }
  else {
    string = "Over an hour ago";
  }
  return string;
};
