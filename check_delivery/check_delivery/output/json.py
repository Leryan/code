import json

from check_delivery.output import Output


class Json(Output):

    def __str__(self):

        output = {
            'status': self.status,
            'message': self.message,
            'details': self.details,
            'durations': self.timers.checkpoints,
            'step': self.step
        }

        return json.dumps(output)
