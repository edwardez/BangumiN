import logging

stream_handler = logging.StreamHandler()


# initialize logger
def initialize_logger(new_logger):
    formatter = logging.Formatter(
        '%(asctime)s %(name)s:%(lineno)d %(levelname)s %(message)s')
    stream_handler.setFormatter(formatter)
    new_logger.addHandler(stream_handler)
    new_logger.setLevel(logging.INFO)

    return new_logger
