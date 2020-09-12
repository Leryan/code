import time


def retry(max_retries=1, wait_between_retry=0, catch_exception=Exception):
    def decorated(func):
        def wrapper(*args, **kwargs):
            try_ex = None
            current_try = 0

            while current_try < max_retries:
                try:
                    response = func(*args, **kwargs)
                    return response

                except catch_exception as ex:
                    try_ex = ex

                current_try += 1
                time.sleep(wait_between_retry)

            if try_ex is not None:
                raise try_ex

        return wrapper
    return decorated
